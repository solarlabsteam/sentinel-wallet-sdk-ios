//
//  SentinelProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation
import GRPC
import NIO
import Alamofire

protocol SentinelProviderType {
    func fetchAvailableNodes(
        offset: UInt64,
        limit: UInt64,
        timeout: TimeInterval,
        completion: @escaping (Result<[DVPNNodeInfo], Error>) -> Void
    )

    func fetchSubscriptions(
        for account: String,
        with status: Sentinel_Types_V1_Status,
        completion: @escaping (Result<[Sentinel_Subscription_V1_Subscription], Error>) -> Void
    )

    func loadActiveSessions(
        for account: String,
        completion: @escaping (Result<[Sentinel_Session_V1_Session], Error>) -> Void
    )

    func broadcastGrpcTx(
        signedRequest: Cosmos_Tx_V1beta1_BroadcastTxRequest,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    )

    func fetchNode(
        address: String,
        completion: @escaping (Result<Sentinel_Node_V1_Node, Error>) -> Void
    )
}

final class SentinelProvider: SentinelProviderType {
    private var sessionManagers = [Session]()
    private let connectionProvider: ClientConnectionProviderType
    private let transactionProvider: TransactionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        return callOptions
    }

    init(
        connectionProvider: ClientConnectionProviderType = ClientConnectionProvider(),
        transactionProvider: TransactionProviderType = TransactionProvider()
    ) {
        self.connectionProvider = connectionProvider
        self.transactionProvider = transactionProvider
    }

    func fetchAvailableNodes(
        offset: UInt64,
        limit: UInt64,
        timeout: TimeInterval,
        completion: @escaping (Result<[DVPNNodeInfo], Error>) -> Void
    ) {
        fetchActiveNodes(offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                self?.fetchInfo(for: nodes, timeout: timeout, completion: completion)
            }
        }
    }

    func fetchSubscriptions(
        for account: String,
        with status: Sentinel_Types_V1_Status = .unspecified,
        completion: @escaping (Result<[Sentinel_Subscription_V1_Subscription], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest.with {
                    $0.address = account
                    $0.status = status
                }
                let response = try Sentinel_Subscription_V1_QueryServiceClient(channel: channel)
                    .querySubscriptionsForAddress(request)
                    .response
                    .wait()

                completion(.success(response.subscriptions))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func broadcastGrpcTx(
        signedRequest: Cosmos_Tx_V1beta1_BroadcastTxRequest,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    ) {
        transactionProvider.broadcastGrpcTx(signedRequest: signedRequest, completion: completion)
    }

    func fetchNode(
        address: String,
        completion: @escaping (Result<Sentinel_Node_V1_Node, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Node_V1_QueryNodeRequest.with {
                    $0.address = address
                }
                let response = try Sentinel_Node_V1_QueryServiceClient(channel: channel)
                    .queryNode(request)
                    .response
                    .wait()
                completion(.success(response.node))
            } catch {
                completion(.failure(error))
            }
        })
    }


    func loadActiveSessions(
        for account: String,
        completion: @escaping (Result<[Sentinel_Session_V1_Session], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Session_V1_QuerySessionsForAddressRequest.with {
                    $0.address = account
                    $0.status = .active
                }
                let response = try Sentinel_Session_V1_QueryServiceClient(channel: channel)
                    .querySessionsForAddress(request)
                    .response
                    .wait()

                completion(.success(response.sessions))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func fetchActiveNodes(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[Sentinel_Node_V1_Node], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                    $0.limit = limit
                    $0.offset = UInt64(offset)
                }
                let request = Sentinel_Node_V1_QueryNodesRequest.with {
                    $0.status = .active
                    $0.pagination = page
                }
                let response = try Sentinel_Node_V1_QueryServiceClient(channel: channel)
                    .queryNodes(request)
                    .response
                    .wait()
                completion(.success(response.nodes))
            } catch {
                completion(.failure(error))
            }
        })
    }
}

private extension SentinelProvider {
    func fetchInfo(
        for nodes: [Sentinel_Node_V1_Node],
        timeout: TimeInterval,
        completion: @escaping (Result<[DVPNNodeInfo], Error>) -> Void
    ) {
        let group = DispatchGroup()
        var loadedNodes = [DVPNNodeInfo]()

        nodes.forEach { node in
            group.enter()
            fetchInfo(for: node.remoteURL, timeout: timeout, completion: { result in
                group.leave()
                switch result {
                case .failure(let error):
                    log.error(error)
                case .success(let nodeResult):
                    guard nodeResult.success, let nodeInfo = nodeResult.result else {
                        log.error("Failed to get info")
                        return
                    }
                    loadedNodes.append(nodeInfo)
                }
            })
        }

        group.notify(queue: .main) { [weak self] in
            self?.sessionManagers = []
            completion(.success(loadedNodes))
        }
    }

    func fetchInfo(
        for nodeURL: String,
        timeout: TimeInterval,
        completion: @escaping (Result<DVPNNodeResponse, Error>) -> Void
    ) {
        let requestType = SentinelAPI.details
        let url = nodeURL.appending(requestType.path)

        guard let host = URL(string: url)?.host else {
            completion(.failure(SentinelProviderError.invalidHost(urlString: nodeURL)))
            return
        }

        let sessionManager = createSession(for: host)
        sessionManagers.append(sessionManager)
        sessionManager.request(url, method: requestType.method) { $0.timeoutInterval = timeout }
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: DataResponse<DVPNNodeResponse, AFError>) in
                switch response.result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let node):
                    completion(.success(node))
                }
            }
    }

    #warning("That's an ugly hack to disable evaluation for all self-signed SSLs, please do better")
    func createSession(for domain: String) -> Session {
        let evaluators: [String: ServerTrustEvaluating] = [domain: DisabledTrustEvaluator()]
        let serverTrustManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: evaluators)

        return Alamofire.Session(serverTrustManager: serverTrustManager)
    }
}
