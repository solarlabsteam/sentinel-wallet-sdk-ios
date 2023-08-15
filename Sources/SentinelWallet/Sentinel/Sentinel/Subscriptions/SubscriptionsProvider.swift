//
//  SubscriptionsProvider.swift
//  
//
//  Created by Lika Vorobeva on 18.07.2022.
//

import Foundation
import GRPC
import NIO

// MARK: - Constants

private struct Constants {
    let startSessionURL = "/sentinel.session.v2.MsgStartRequest"
    let stopSessionURL = "/sentinel.session.v2.MsgEndRequest"

    let subscribeToNodeURL = "/sentinel.node.v2.MsgSubscribeRequest"
    let cancelSubscriptionURL = "/sentinel.subscription.v2.MsgCancelRequest"
}
private let constants = Constants()

final public class SubscriptionsProvider {
    private let connectionProvider: ClientConnectionProviderType
    private let transactionProvider: TransactionProviderType
    
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }

    public init(configuration: ClientConnectionConfigurationType) {
        self.connectionProvider = ClientConnectionProvider(configuration: configuration)
        self.transactionProvider = TransactionProvider(configuration: configuration)
    }
}

// MARK: - Subscribe & cancel

extension SubscriptionsProvider: SubscriptionsProviderType {
    public func queryAllocation(
        address: String,
        subscriptionId: UInt64,
        completion: @escaping (Result<Allocation, Error>) -> Void
    ){
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V2_QueryAllocationRequest.with {
                    $0.address = address
                    $0.id = subscriptionId
                }
                let response = try Sentinel_Subscription_V2_QueryServiceClient(channel: channel)
                    .queryAllocation(request, callOptions: self.callOptions)
                    .response
                    .wait()

                completion(.success(Allocation(from: response.allocation)))
            } catch {
                completion(.failure(error))
            }
        })
    }

    public func subscribe(
        sender: TransactionSender,
        node: String,
        denom: String,
        gigabytes: Int64,
        hours: Int64,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let startMessage = Sentinel_Node_V2_MsgSubscribeRequest.with {
            $0.from = sender.owner
            $0.nodeAddress = node
            $0.gigabytes = gigabytes
            $0.hours = hours
            $0.denom = denom
        }

        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.subscribeToNodeURL
            $0.value = try! startMessage.serializedData()
        }

        transactionProvider.broadcast(
            sender: sender,
            recipient: node,
            messages: [anyMessage],
            gasFactor: 0,
            completion: completion
        )
    }
    
    /// Cancel any type of subscription (to a node or to a plan)
    public func cancel(
        subscriptions: [UInt64],
        sender: TransactionSender,
        node: String,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let messages = subscriptions.map { subscriptionID -> Google_Protobuf2_Any in
            let startMessage = Sentinel_Subscription_V2_MsgCancelRequest.with {
                $0.id = subscriptionID
                $0.from = sender.owner
            }

            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = constants.cancelSubscriptionURL
                $0.value = try! startMessage.serializedData()
            }
            
            return anyMessage
        }
        
        transactionProvider.broadcast(
            sender: sender,
            recipient: node,
            messages: messages,
            gasFactor: subscriptions.count,
            completion: completion
        )
    }
}

// MARK: - Subscriptions info

#warning("TODO: map Google_Protobuf_Any to new Subscription types")

extension SubscriptionsProvider {
//    public func querySubscription(
//        with id: UInt64,
//        completion: @escaping (Result<Subscription, Error>) -> Void
//    ) {
//        connectionProvider.openConnection(for: { channel in
//            do {
//                let request = Sentinel_Subscription_V2_QuerySubscriptionRequest.with {
//                    $0.id = id
//                }
//                let response = try Sentinel_Subscription_V2_QueryServiceClient(channel: channel)
//                    .querySubscription(request, callOptions: self.callOptions)
//                    .response
//                    .wait()
//                #warning("TODO: map Google_Protobuf_Any to new Subscription types")
////                completion(.success(Subscription(from: response)))
//            } catch {
//                completion(.failure(error))
//            }
//        })
//    }
//
//    public func querySubscriptions(
//        for account: String,
//        with status: SubscriptionStatus = .unspecified,
//        completion: @escaping (Result<[Subscription], Error>) -> Void
//    ) {
//        var callOptions = CallOptions()
//        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
//
//        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
//            $0.limit = 1000
//            $0.offset = 0
//        }
//
//        connectionProvider.openConnection(for: { channel in
//            do {
//                let request = Sentinel_Subscription_V2_QuerySubscriptionsForAccountRequest.with {
//                    $0.address = account
//                    $0.pagination = page
//                }
//                let response = try Sentinel_Subscription_V2_QueryServiceClient(channel: channel)
//                    .querySubscriptionsForAccount(request, callOptions: callOptions)
//                    .response
//                    .wait()
//
////                completion(.success(response.subscriptions.map(Subscription.init(from:))))
//            } catch {
//                completion(.failure(error))
//            }
//        })
//    }
}
    
// MARK: - Sessions

extension SubscriptionsProvider {
    public func startNewSession(
        on subscriptionID: UInt64,
        activeSession: UInt64?,
        sender: TransactionSender,
        node: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        let stopMessage = formStopMessage(activeSession: activeSession, sender: sender)
        let startMessage = Sentinel_Session_V2_MsgStartRequest.with {
            $0.id = subscriptionID
            $0.from = sender.owner
            $0.address = node
        }
        
        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.startSessionURL
            $0.value = try! startMessage.serializedData()
        }
        
        let messages = stopMessage + [anyMessage]
        
        transactionProvider.broadcast(
            sender: sender,
            recipient: node,
            messages: messages,
            gasFactor: 0
        ) { result in
            let mapped =  result.map { $0.isSuccess }
            completion(mapped)
        }
    }
    
    public func stop(
        activeSession: UInt64,
        node: String,
        sender: TransactionSender,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        let stopMessage = formStopMessage(activeSession: activeSession, sender: sender)
        transactionProvider.broadcast(
            sender: sender,
            recipient: node,
            messages: stopMessage,
            gasFactor: 0
        ) { result in
            let mapped =  result.map { $0.isSuccess }
            completion(mapped)
        }
    }
    
    private func formStopMessage(activeSession: UInt64?, sender: TransactionSender) -> [Google_Protobuf2_Any] {
        guard let activeSession = activeSession else { return [] }
        let stopMessage = Sentinel_Session_V2_MsgEndRequest.with {
            $0.id = activeSession
            $0.from = sender.owner
        }
        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.stopSessionURL
            $0.value = try! stopMessage.serializedData()
        }
        return [anyMessage]
    }
}
