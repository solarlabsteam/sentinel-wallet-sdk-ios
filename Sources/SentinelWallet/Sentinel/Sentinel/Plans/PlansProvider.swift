//
//  PlansProvider.swift
//  
//
//  Created by Lika Vorobeva on 18.07.2022.
//

import Foundation
import GRPC
import NIO

// MARK: - Constants

private struct Constants {
    let subscribeToPlanURL = "/sentinel.subscription.v1.MsgSubscribeToPlanRequest"
}
private let constants = Constants()

final public class PlansProvider {
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
}

// MARK: - Subscribe & cancel

extension PlansProvider: PlansProviderType {
    public func subscribe(
        to planID: UInt64,
        denom: String,
        transactionData: TransactionData,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let startMessage = Sentinel_Subscription_V1_MsgSubscribeToPlanRequest.with {
            $0.from = transactionData.owner
            $0.id = planID
            $0.denom = denom
        }
        
        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.subscribeToPlanURL
            $0.value = try! startMessage.serializedData()
        }
        
        transactionProvider.broadcast(
            data: transactionData,
            messages: [anyMessage],
            gasFactor: 0,
            completion: completion
        )
    }
    
    public func queryProviders(
        offset: UInt64 = 0,
        limit: UInt64 = 0,
        completion: @escaping (Result<[SentinelNodesProvider], Error>) -> Void
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
                completion(.success(response.providers.map { SentinelNodesProvider.init(from: $0) }))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    public func queryPlans(
        offset: UInt64 = 0,
        limit: UInt64 = 1000,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
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
                completion(.success(response.plans.map(SentinelPlan.init)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    public func queryPlans(
        for providerAddress: String,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Plan_V1_QueryPlansForProviderRequest.with {
                    $0.address = providerAddress
                }
                let response = try Sentinel_Plan_V1_QueryServiceClient(channel: channel)
                    .queryPlansForProvider(request)
                    .response
                    .wait()
                completion(.success(response.plans.map(SentinelPlan.init)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    public func queryNodesForPlan(
        with id: UInt64,
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Plan_V1_QueryNodesForPlanRequest.with {
                    $0.id = id
                }
                let response = try Sentinel_Plan_V1_QueryServiceClient(channel: channel)
                    .queryNodesForPlan(request)
                    .response
                    .wait()
                completion(.success(response.nodes.map { SentinelNode(from: $0) }))
            } catch {
                completion(.failure(error))
            }
        })
    }
}


//    func fetchPlans(
//        offset: UInt64,
//        limit: UInt64,
//        completion: @escaping (Result<[Sentinel_Plan_V1_Plan], Error>) -> Void
//    ) {
//
//    }
//
