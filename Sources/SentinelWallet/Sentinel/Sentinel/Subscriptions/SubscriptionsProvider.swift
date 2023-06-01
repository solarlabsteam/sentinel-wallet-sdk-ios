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
    let startSessionURL = "/sentinel.session.v1.MsgStartRequest"
    let stopSessionURL = "/sentinel.session.v1.MsgEndRequest"
    let subscribeToNodeURL = "/sentinel.subscription.v1.MsgSubscribeToNodeRequest"
    let cancelSubscriptionURL = "/sentinel.subscription.v1.MsgCancelRequest"
    let addQuotaURL = "/sentinel.subscription.v1.MsgAddQuotaRequest"
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
    public func queryQuota(
        address: String,
        subscriptionId: UInt64,
        completion: @escaping (Result<Quota, Error>) -> Void
    ){
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
                completion(.success(Quota(from: response.quota)))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    public func subscribe(
        sender: TransactionSender,
        node: String,
        deposit: CoinToken,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let sendCoin = Cosmos_Base_V1beta1_Coin.with {
            $0.denom = deposit.denom
            $0.amount = deposit.amount
        }
        
        let startMessage = Sentinel_Subscription_V1_MsgSubscribeToNodeRequest.with {
            $0.from = sender.owner
            $0.address = node
            $0.deposit = sendCoin
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
            let startMessage = Sentinel_Subscription_V1_MsgCancelRequest.with {
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

extension SubscriptionsProvider {
    public func querySubscription(
        with id: UInt64,
        completion: @escaping (Result<Subscription, Error>) -> Void
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
                
                completion(.success(Subscription(from: response.subscription)))
            } catch {
                completion(.failure(error))
            }
        })
    }

    public func querySubscriptions(
        for account: String,
        with status: SubscriptionStatus = .unspecified,
        completion: @escaping (Result<[Subscription], Error>) -> Void
    ) {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        
        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
            $0.limit = 1000
            $0.offset = 0
        }
        
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest.with {
                    $0.address = account
                    $0.status = .init(from: status) ?? Sentinel_Types_V1_Status.unspecified
                    $0.pagination = page
                }
                let response = try Sentinel_Subscription_V1_QueryServiceClient(channel: channel)
                    .querySubscriptionsForAddress(request, callOptions: callOptions)
                    .response
                    .wait()
                
                completion(.success(response.subscriptions.map(Subscription.init(from:))))
            } catch {
                completion(.failure(error))
            }
        })
    }
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
        let startMessage = Sentinel_Session_V1_MsgStartRequest.with {
            $0.id = subscriptionID
            $0.from = sender.owner
            $0.node = node
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
        let stopMessage = Sentinel_Session_V1_MsgEndRequest.with {
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
