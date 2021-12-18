//
//  SentinelService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

private struct Constants {
    let startSessionURL = "/sentinel.session.v1.MsgService/MsgStart"
    let stopSessionURL = "/sentinel.session.v1.MsgService/MsgEnd"
    let subscribeToNodeURL = "/sentinel.subscription.v1.MsgService/MsgSubscribeToNode"
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
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        provider.fetchAvailableNodes(offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                completion(.success(nodes))
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
        completion: @escaping (Result<[Subscription], Error>) -> Void
    ) {
        provider.fetchSubscriptions(for: walletService.accountAddress, with: .unspecified) { result in
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
        on subscription: Subscription,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        // fetch account subscriptions
        provider.fetchSubscriptions(for: walletService.accountAddress, with: .active) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion(.failure(error))
            case .success(let subscriptions):
                if let activeSubscription = subscriptions.first(
                    where: { $0.id == subscription.id && $0.node == subscription.node }
                ) {
                    self?.connect(to: activeSubscription, completion: completion)
                } else {
                    completion(.failure(SentinelServiceError.sessionStartFailed))
                }
            }
        }
    }
}

private extension SentinelService {
    func connect(
        to subscription: Sentinel_Subscription_V1_Subscription,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        stopActiveSessionsMessages { [weak self] messages in
            guard let self = self else {
                completion(.failure(SentinelServiceError.broadcastFailed))
                return
            }
            let startMessage = Sentinel_Session_V1_MsgStartRequest.with {
                $0.id = subscription.id
                $0.from = self.walletService.accountAddress
                $0.node = subscription.node
            }

            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = constants.startSessionURL
                $0.value = try! startMessage.serializedData()
            }

            let messages = messages + [anyMessage]

            self.generateAndBroadcast(to: subscription.node, messages: messages) { result in
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

    func broadcast(request: Cosmos_Tx_V1beta1_BroadcastTxRequest, completion: @escaping (Result<TransactionResult, Error>) -> Void) {
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
