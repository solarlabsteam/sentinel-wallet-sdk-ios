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
}
private let constants = Constants()

enum SentinelServiceError: Error {
    case broadcastFailed
}

final public class SentinelService {
    private let provider: SentinelProviderType
    private let walletService: WalletService

    public init(walletService: WalletService) {
        provider = SentinelProvider()
        self.walletService = walletService
    }

    public func queryNodeInfo(completion: @escaping (Result<(address: String, url: String), Error>) -> Void) {
        provider.fetchNode() { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let node):
                completion(.success((node.address, node.remoteURL)))
            }
        }
    }

    public func loadActiveSession(completion: @escaping (Result<UInt64, Error>) -> Void) {
        provider.loadActiveSessions(for: walletService.accountAddress) {  result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let sessions):
                guard let sessionID = sessions.last?.id else {
                    log.error("Failed to start a session: no id or empty array")
                    completion(.failure(SentinelServiceError.broadcastFailed))
                    return
                }
                completion(.success(sessionID))
            }
        }
    }

    public func subscribe(
        to node: String,
        deposit: CoinToken,
        completion: @escaping (Result<Bool, Error>) -> Void
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

    public func startNewSession(
        on subscription: Subscription,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        // fetch account subscriptions
        provider.fetchSubscriptions(for: walletService.accountAddress, with: .active) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let subscriptions):
                if let activeSubscription = subscriptions.first(
                    where: { $0.id == subscription.id && $0.node == subscription.node }
                ) {
                    self?.connect(to: activeSubscription, completion: completion)
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
                case .success(let isSuccess):
                    guard isSuccess else {
                        log.error("Failed to start a session")
                        completion(.failure(SentinelServiceError.broadcastFailed))
                        return
                    }

                    self.loadActiveSession(completion: completion)
                }
            }
        }
    }

    func generateAndBroadcast(
        to node: String,
        messages: [Google_Protobuf2_Any],
        completion: @escaping (Result<Bool, Error>) -> Void
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

    func broadcast(request: Cosmos_Tx_V1beta1_BroadcastTxRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.broadcastGrpcTx(signedRequest: request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let response):
                log.debug(response)
                #warning("Response may contain some errors in body even if broadcast is succesfull. Consider parsing them")
                completion(.success(true))
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
