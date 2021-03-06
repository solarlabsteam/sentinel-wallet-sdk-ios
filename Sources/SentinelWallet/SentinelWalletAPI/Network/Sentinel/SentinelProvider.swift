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
        allowedDenoms: [String],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    )
    
    func fetchProviders(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[Sentinel_Provider_V1_Provider], Error>) -> Void
    )

    func fetchPlans(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[Sentinel_Plan_V1_Plan], Error>) -> Void
    )
    
    func fetchPlans(
        for provider: String,
        completion: @escaping (Result<[Sentinel_Plan_V1_Plan], Error>) -> Void
    )

    func fetchNodes(
        for planID: UInt64,
        completion: @escaping (Result<[Sentinel_Node_V1_Node], Error>) -> Void
    )
    
    func fetchSubscription(
        with id: UInt64,
        completion: @escaping (Result<Sentinel_Subscription_V1_Subscription, Error>) -> Void
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

    func fetchInfo(
        for nodeURL: String,
        timeout: TimeInterval,
        completion: @escaping (Result<(DVPNNodeResponse, TimeInterval), Error>) -> Void
    )

    func fetchQuota(
        address: String,
        subscriptionId: UInt64,
        completion: @escaping (Result<Sentinel_Subscription_V1_Quota, Error>) -> Void
    )
}

final class SentinelProvider: SentinelProviderType {
    private let connectionProvider: ClientConnectionProviderType
    private let transactionProvider: TransactionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }

    init(
        host: String,
        port: Int
    ) {
        self.connectionProvider = ClientConnectionProvider(host: host, port: port)
        self.transactionProvider = TransactionProvider(host: host, port: port)
    }
    
    func fetchAvailableNodes(
        offset: UInt64,
        limit: UInt64,
        allowedDenoms: [String] = [GlobalConstants.denom],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        fetchActiveNodes(offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                let sentinelNodes = nodes
                    .filter { node in allowedDenoms.contains(where: node.price.map { $0.denom }.contains)  }
                    .map { SentinelNode(from: $0) }
                completion(.success(sentinelNodes))
            }
        }
    }

    func fetchSubscriptions(
        for account: String,
        with status: Sentinel_Types_V1_Status = .unspecified,
        completion: @escaping (Result<[Sentinel_Subscription_V1_Subscription], Error>) -> Void
    ) {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest.with {
                    $0.address = account
                    $0.status = status
                }
                let response = try Sentinel_Subscription_V1_QueryServiceClient(channel: channel)
                    .querySubscriptionsForAddress(request, callOptions: callOptions)
                    .response
                    .wait()

                completion(.success(response.subscriptions))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func fetchSubscription(
        with id: UInt64,
        completion: @escaping (Result<Sentinel_Subscription_V1_Subscription, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V1_QuerySubscriptionRequest.with {
                    $0.id = id
                }
                let response = try Sentinel_Subscription_V1_QueryServiceClient(channel: channel)
                    .querySubscription(request, callOptions: self.callOptions)
                    .response
                    .wait()

                completion(.success(response.subscription))
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
                    .queryNode(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.node))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    func fetchProviders(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[Sentinel_Provider_V1_Provider], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                    $0.limit = limit
                    $0.offset = UInt64(offset)
                }
                let request = Sentinel_Provider_V1_QueryProvidersRequest.with {
                    $0.pagination = page
                }
                let response = try Sentinel_Provider_V1_QueryServiceClient(channel: channel)
                    .queryProviders(request)
                    .response
                    .wait()
                completion(.success(response.providers))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    func fetchPlans(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[Sentinel_Plan_V1_Plan], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                    $0.limit = limit
                    $0.offset = UInt64(offset)
                }
                let request = Sentinel_Plan_V1_QueryPlansRequest.with {
                    $0.pagination = page
                }
                let response = try Sentinel_Plan_V1_QueryServiceClient(channel: channel)
                    .queryPlans(request)
                    .response
                    .wait()
                completion(.success(response.plans))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    func fetchNodes(
        for planID: UInt64,
        completion: @escaping (Result<[Sentinel_Node_V1_Node], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Plan_V1_QueryNodesForPlanRequest.with {
                    $0.id = planID
                }
                let response = try Sentinel_Plan_V1_QueryServiceClient(channel: channel)
                    .queryNodesForPlan(request)
                    .response
                    .wait()
                completion(.success(response.nodes))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    func fetchPlans(
        for provider: String,
        completion: @escaping (Result<[Sentinel_Plan_V1_Plan], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Plan_V1_QueryPlansForProviderRequest.with {
                    $0.address = provider
                }
                let response = try Sentinel_Plan_V1_QueryServiceClient(channel: channel)
                    .queryPlansForProvider(request)
                    .response
                    .wait()
                completion(.success(response.plans))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func fetchQuota(
        address: String,
        subscriptionId: UInt64,
        completion: @escaping (Result<Sentinel_Subscription_V1_Quota, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V1_QueryQuotaRequest.with {
                    $0.address = address
                    $0.id = subscriptionId
                }
                let response = try Sentinel_Subscription_V1_QueryServiceClient(channel: channel)
                    .queryQuota(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.quota))
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
                    .querySessionsForAddress(request, callOptions: self.callOptions)
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
                    .queryNodes(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.nodes))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    func fetchInfo(
        for nodeURL: String,
        timeout: TimeInterval,
        completion: @escaping (Result<(DVPNNodeResponse, TimeInterval), Error>) -> Void
    ) {
        let requestType = SentinelAPI.details
        let url = nodeURL.appending(requestType.path)

        guard var comps = URLComponents(string: url) else {
            completion(.failure(SentinelProviderError.invalidHost(urlString: nodeURL)))
            return
        }

        comps.scheme = "http"

        guard let urlString = comps.string else {
            completion(.failure(SentinelProviderError.invalidHost(urlString: nodeURL)))
            return
        }

        AF.request(urlString, method: requestType.method) { $0.timeoutInterval = timeout }
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: DataResponse<DVPNNodeResponse, AFError>) in
                switch response.result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let node):
                    let duration = response.metrics?.taskInterval.duration ?? 0
                    completion(.success((node, duration)))
                }
            }
    }
}
