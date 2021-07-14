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

private struct Constants {
    #warning("Adjust limit after resolving loading flow")
    let limit: UInt64 = 30
}

private let constants = Constants()

protocol SentinelProviderType {
    func fetchAvailableNodes(
        offset: UInt64,
        completion: @escaping (Result<[Sentinel_Node_V1_Node: DVPNNodeInfo], Error>) -> Void
    )
}

final class SentinelProvider: SentinelProviderType {
    private var sessionManagers = [Session]()
    private let connectionProvider: ClientConnectionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        return callOptions
    }

    init(connectionProvider: ClientConnectionProviderType = ClientConnectionProvider()) {
        self.connectionProvider = connectionProvider
    }

    func fetchAvailableNodes(
        offset: UInt64,
        completion: @escaping (Result<[Sentinel_Node_V1_Node: DVPNNodeInfo], Error>) -> Void
    ) {
        fetchActiveNodes(offset: offset) { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                self?.fetchInfo(for: nodes, completion: completion)
            }
        }
    }
}

private extension SentinelProvider {
    func fetchActiveNodes(
        offset: UInt64,
        completion: @escaping (Result<[Sentinel_Node_V1_Node], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                    $0.limit = constants.limit
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


    #warning("TODO: remove dictionary")
    /// DVPNNodeInfo doesn't have all needed info probably, like status. If it's decided that keeping Sentinel_Node_V1_Node is not needed after getting the info,
    /// even though the Price could be restored from string in DVPNNodeInfo, some validation should be at least done (account == account, etc) to ensure data's consistent
    func fetchInfo(
        for nodes: [Sentinel_Node_V1_Node],
        completion: @escaping (Result<[Sentinel_Node_V1_Node: DVPNNodeInfo], Error>) -> Void
    ) {
        let group = DispatchGroup()
        var loadedNodes = [Sentinel_Node_V1_Node: DVPNNodeInfo]()

        nodes.forEach { node in
            group.enter()
            fetchInfo(for: node.remoteURL, completion: { result in
                group.leave()
                switch result {
                case .failure(let error):
                    log.error(error)
                case .success(let nodeResult):
                    guard nodeResult.success, let nodeInfo = nodeResult.result else {
                        log.error("Failed to get info")
                        return
                    }
                    loadedNodes[node] = nodeInfo
                }
            })
        }

        group.notify(queue: .main) { [weak self] in
            self?.sessionManagers = []
            completion(.success(loadedNodes))
        }
    }

    func fetchInfo(for nodeURL: String, completion: @escaping (Result<DVPNNodeResponse, Error>) -> Void) {
        let requestType = SentinelAPI.details
        let url = nodeURL.appending(requestType.path)

        guard let host = URL(string: url)?.host else {
            completion(.failure(SentinelProviderError.invalidHost(urlString: nodeURL)))
            return
        }

        let sessionManager = createSession(for: host)
        sessionManagers.append(sessionManager)
        sessionManager.request(url, method: requestType.method)
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
