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

    init(
        host: String,
        port: Int
    ) {
        self.connectionProvider = ClientConnectionProvider(host: host, port: port)
        self.transactionProvider = TransactionProvider(host: host, port: port)
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
        transactionData: TransactionData,
        deposit: CoinToken,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let sendCoin = Cosmos_Base_V1beta1_Coin.with {
            $0.denom = deposit.denom
            $0.amount = deposit.amount
        }
        
        let startMessage = Sentinel_Subscription_V1_MsgSubscribeToNodeRequest.with {
            $0.from = transactionData.owner
            $0.address = transactionData.recipient
            $0.deposit = sendCoin
        }

        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.subscribeToNodeURL
            $0.value = try! startMessage.serializedData()
        }

        transactionProvider.broadcast(
            data: transactionData,
            messages: [anyMessage],
            gasFactor: 0,
            completion: completion
        )
    }
    
    /// Cancel any type of subscription (to a node or to a plan)
    public func cancel(
        subscriptions: [UInt64],
        transactionData: TransactionData,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let messages = subscriptions.map { subscriptionID -> Google_Protobuf2_Any in
            let startMessage = Sentinel_Subscription_V1_MsgCancelRequest.with {
                $0.id = subscriptionID
                $0.from = transactionData.owner
            }

            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = constants.cancelSubscriptionURL
                $0.value = try! startMessage.serializedData()
            }
            
            return anyMessage
        }
        
        transactionProvider.broadcast(
            data: transactionData,
            messages: messages,
            gasFactor: 0,
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
        
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest.with {
                    $0.address = account
                    $0.status = .init(from: status) ?? Sentinel_Types_V1_Status.unspecified
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
        data: TransactionData,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        stopActiveSessionsMessages(for: data.owner) { [weak self] messages in
            guard let self = self else {
                completion(.failure(SubscriptionsProviderError.broadcastFailed))
                return
            }
            let startMessage = Sentinel_Session_V1_MsgStartRequest.with {
                $0.id = subscriptionID
                $0.from = data.owner
                $0.node = data.recipient
            }
            
            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = constants.startSessionURL
                $0.value = try! startMessage.serializedData()
            }
            
            let messages = messages + [anyMessage]
            
            
            self.transactionProvider.broadcast(data: data, messages: messages, memo: nil, gasFactor: 0) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    guard TransactionResult(from: response.txResponse).isSuccess else {
                        log.error("Failed to start a session")
                        completion(.failure(SubscriptionsProviderError.broadcastFailed))
                        return
                    }
                    
                    self.queryActiveSessions(for: data.owner) { result in
                        switch result {
                        case let .failure(error):
                            completion(.failure(error))
                        case let .success(sessions):
                            guard let session = sessions.last else {
                                log.error("Failed to start a session: no id or empty array")
                                completion(.failure(SubscriptionsProviderError.sessionStartFailed))
                                return
                            }
                            completion(.success(session.id))
                        }
                    }
                }
            }
        }
    }
    
    public func queryActiveSessions(for account: String, completion: @escaping (Result<[Session], Error>) -> Void) {
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
                
                completion(.success(response.sessions.map(Session.init(from:))))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    public func stopActiveSessions(
        transactionData: TransactionData,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        queryActiveSessions(for: transactionData.owner) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let sessions):
                guard !sessions.isEmpty else {
                    completion(.success(()))
                    return
                }
                
                let group = DispatchGroup()
                var errorAppeared = false
                sessions.forEach { session in
                    group.enter()
                    let stopMessage = Sentinel_Session_V1_MsgEndRequest.with {
                        $0.id = session.id
                        $0.from = transactionData.owner
                    }
                    
                    let anyMessage = Google_Protobuf2_Any.with {
                        $0.typeURL = constants.stopSessionURL
                        $0.value = try! stopMessage.serializedData()
                    }
                    
                    self.transactionProvider.broadcast(
                        data: transactionData,
                        messages: [anyMessage],
                        gasFactor: 0
                    ) { result in
                        group.leave()
                        if case let .failure(error) = result {
                            log.error(error)
                            errorAppeared = true
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    guard !errorAppeared else {
                        completion(.failure(SubscriptionsProviderError.sessionsStopFailed))
                        return
                    }
                    completion(.success(()))
                }
            }
        }
    }
}

// MARK: - Private functions

extension SubscriptionsProvider {
    private func stopActiveSessionsMessages(
        for account: String,
        completion: @escaping ([Google_Protobuf2_Any]) -> Void
    ) {
        queryActiveSessions(for: account) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion([])
                
            case .success(let sessions):
                guard !sessions.isEmpty else {
                    completion([])
                    return
                }
                
                let messages = sessions.map { session in
                    Sentinel_Session_V1_MsgEndRequest.with {
                        $0.id = session.id
                        $0.from = account
                    }}.map { stopMessage in
                        Google_Protobuf2_Any.with {
                            $0.typeURL = constants.stopSessionURL
                            $0.value = try! stopMessage.serializedData()
                        }
                    }
                
                completion(messages)
            }
        }
    }
}

