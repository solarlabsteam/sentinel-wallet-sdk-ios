//
//  SentinelService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation
import UIKit

private struct Constants {
    let startSessionURL = "/sentinel.session.v1.MsgService/MsgStart"
    let stopSessionURL = "/sentinel.session.v1.MsgService/MsgEnd"
    let subscribeToNodeURL = "/sentinel.subscription.v1.MsgService/MsgSubscribeToNode"
    let cancelSubscriptionURL = "/sentinel.subscription.v1.MsgService/MsgCancel"
    let subscribeToPlanURL = "/sentinel.subscription.v1.MsgService/MsgSubscribeToPlan"
    let addQuotaURL = "/sentinel.subscription.v1.MsgService/MsgAddQuota"
}
private let constants = Constants()

public enum SentinelServiceError: Error {
    case broadcastFailed
    case emptyInfo
    case sessionStartFailed
}

final public class SentinelService {
    private let provider: SentinelProviderType
    private let walletService: WalletService

    public init(walletService: WalletService) {
        provider = SentinelProvider()
        self.walletService = walletService
    }
    
    public func queryNodes(
        offset: UInt64 = 0,
        limit: UInt64 = 0,
        allowedDenoms: [String] = [GlobalConstants.denom],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        provider.fetchAvailableNodes(offset: offset, limit: limit, allowedDenoms: allowedDenoms) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                completion(.success(nodes))
            }
        }
    }
    
    public func queryProviders(
        offset: UInt64 = 0,
        limit: UInt64 = 0,
        completion: @escaping (Result<[SentinelNodesProvider], Error>) -> Void
    ) {
        provider.fetchProviders(offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let providers):
                completion(.success(providers.map { SentinelNodesProvider.init(from: $0) }))
            }
        }
    }
    
    public func queryPlans(
        offset: UInt64 = 0,
        limit: UInt64 = 1000,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    ) {
        provider.fetchPlans(offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let plans):
                completion(.success(plans.map(SentinelPlan.init)))
            }
        }
    }

    public func queryPlans(
        for providerAddress: String,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    ) {
        provider.fetchPlans(for: providerAddress) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let plans):
                completion(.success(plans.map(SentinelPlan.init)))
            }
        }
    }
    
    public func queryNodesForPlan(
        with id: UInt64,
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        provider.fetchNodes(for: id) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                let sentinelNodes = nodes.map { SentinelNode(from: $0) }
                completion(.success(sentinelNodes))
            }
        }
    }
    
    public func fetchInfo(
        for sentinelNode: SentinelNode,
        timeout: TimeInterval,
        completion: @escaping (Result<Node, Error>) -> Void
    ) {
        self.provider.fetchInfo(for: sentinelNode.remoteURL, timeout: timeout) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodeResult):
                guard nodeResult.0.success, let nodeInfo = nodeResult.0.result else {
                    log.error("Failed to get info")
                    return
                }
                
                let node = Node(info: nodeInfo, latency: nodeResult.1)
                completion(.success(node))
            }
        }
    }

    public func queryQuota(
        subscriptionID: UInt64,
        completion: @escaping (Result<Quota, Error>) -> Void
    ) {
        provider.fetchQuota(address: walletService.accountAddress, subscriptionId: subscriptionID) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let quota):
                completion(.success(Quota.init(from: quota)))
            }
        }
    }
    
    public func queryNodeStatus(
        address: String,
        timeout: TimeInterval,
        completion: @escaping (Result<SentinelNode, Error>) -> Void
    ) {
        provider.fetchNode(address: address) { [weak self] result in
            guard let self = self else {
                completion(.failure(SentinelServiceError.emptyInfo))
                return
            }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let sentinelNodeV1Node):
                self.provider.fetchInfo(for: sentinelNodeV1Node.remoteURL, timeout: timeout) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let info):
                        guard info.0.success, let result = info.0.result else {
                            completion(.failure(SentinelServiceError.emptyInfo))
                            return
                        }
                        
                        let node = Node(info: result, latency: info.1)
                        completion(.success(.init(from: sentinelNodeV1Node, node: node)))
                    }
                }
            }
        }
    }

    public func loadActiveSession(completion: @escaping (Result<Session, Error>) -> Void) {
        provider.loadActiveSessions(for: walletService.accountAddress) {  result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let sessions):
                guard let session = sessions.last else {
                    log.error("Failed to start a session: no id or empty array")
                    completion(.failure(SentinelServiceError.sessionStartFailed))
                    return
                }
                completion(.success(Session(from: session)))
            }
        }
    }

    public func subscribe(
        to node: String,
        deposit: CoinToken,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let sendCoin = Cosmos_Base_V1beta1_Coin.with {
            $0.denom = deposit.denom
            $0.amount = deposit.amount
        }
        
        let startMessage = Sentinel_Subscription_V1_MsgSubscribeToNodeRequest.with {
            $0.from = walletService.accountAddress
            $0.address = node
            $0.deposit = sendCoin
        }

        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.subscribeToNodeURL
            $0.value = try! startMessage.serializedData()
        }

        generateAndBroadcast(to: node, messages: [anyMessage], completion: completion)
    }
    
    public func cancel(
        subscriptions: [UInt64],
        node: String,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let messages = subscriptions.map { subscriptionID -> Google_Protobuf2_Any in
            let startMessage = Sentinel_Subscription_V1_MsgCancelRequest.with {
                $0.id = subscriptionID
                $0.from = walletService.accountAddress
            }

            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = constants.cancelSubscriptionURL
                $0.value = try! startMessage.serializedData()
            }
            
            return anyMessage
        }
        
        generateAndBroadcast(to: node, messages: messages, completion: completion)
    }
    
    public func subscribe(
        to planID: UInt64,
        provider: String,
        denom: String,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let startMessage = Sentinel_Subscription_V1_MsgSubscribeToPlanRequest.with {
            $0.from = walletService.accountAddress
            $0.id = planID
            $0.denom = denom
        }

        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.subscribeToPlanURL
            $0.value = try! startMessage.serializedData()
        }

        generateAndBroadcast(to: provider, messages: [anyMessage], completion: completion)
    }
    
    /// Add quota to existing subscribtion
    public func addQuota(
        to address: String,
        bytes: String,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        let startMessage = Sentinel_Subscription_V1_MsgAddQuotaRequest.with {
            $0.from = walletService.accountAddress
            $0.address = address
            $0.bytes = bytes
        }

        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.addQuotaURL
            $0.value = try! startMessage.serializedData()
        }

        generateAndBroadcast(to: address, messages: [anyMessage], completion: completion)
    }

    public func fetchSubscriptions(
        with status: SubscriptionStatus = .unspecified,
        completion: @escaping (Result<[Subscription], Error>) -> Void
    ) {
        provider.fetchSubscriptions(
            for: walletService.accountAddress,
               with: .init(from: status) ?? Sentinel_Types_V1_Status.unspecified
        ) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion(.failure(error))
            case .success(let subscriptions):
                completion(.success(subscriptions.map(Subscription.init(from:))))
            }
        }
    }

    public func fetchSubscription(
        with id: UInt64,
        completion: @escaping (Result<Subscription, Error>) -> Void
    ) {
        provider.fetchSubscription(with: id) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion(.failure(error))
            case .success(let subscription):
                completion(.success(Subscription(from: subscription)))
            }
        }
    }

    public func startNewSession(
        on subscriptionId: UInt64, nodeAddress: String,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        connect(to: subscriptionId, nodeAddress: nodeAddress, completion: completion)
    }
}

private extension SentinelService {
    func connect(
        to subscriptionID: UInt64, nodeAddress: String,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        stopActiveSessionsMessages { [weak self] messages in
            guard let self = self else {
                completion(.failure(SentinelServiceError.broadcastFailed))
                return
            }
            let startMessage = Sentinel_Session_V1_MsgStartRequest.with {
                $0.id = subscriptionID
                $0.from = self.walletService.accountAddress
                $0.node = nodeAddress
            }

            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = constants.startSessionURL
                $0.value = try! startMessage.serializedData()
            }

            let messages = messages + [anyMessage]

            self.generateAndBroadcast(to: nodeAddress, messages: messages) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    guard response.isSuccess else {
                        log.error("Failed to start a session")
                        completion(.failure(SentinelServiceError.broadcastFailed))
                        return
                    }

                    self.loadActiveSession { result in
                        switch result {
                        case let .failure(error):
                            completion(.failure(error))
                        case let .success(session):
                            completion(.success(session.id))
                        }
                    }
                }
            }
        }
    }

    func generateAndBroadcast(
        to node: String,
        messages: [Google_Protobuf2_Any],
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        walletService.generateSignedRequest(to: node, messages: messages) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion(.failure(error))

            case .success(let request):
                self?.broadcast(request: request, completion: completion)
            }
        }
    }

    func broadcast(
        request: Cosmos_Tx_V1beta1_BroadcastTxRequest,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        provider.broadcastGrpcTx(signedRequest: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let response):
                log.debug(response)
                completion(.success(TransactionResult(from: response.txResponse)))
            }
        }
    }

    func stopActiveSessionsMessages(completion: @escaping ([Google_Protobuf2_Any]) -> Void) {
        provider.loadActiveSessions(for: walletService.accountAddress) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                log.error(error)
                completion([])

            case .success(let sessions):
                log.debug(sessions)

                guard !sessions.isEmpty else {
                    completion([])
                    return
                }

                let messages = sessions.map { session in
                    Sentinel_Session_V1_MsgEndRequest.with {
                        $0.id = session.id
                        $0.from = self.walletService.accountAddress
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
