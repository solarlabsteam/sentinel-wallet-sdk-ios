//
//  SentinelService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

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

    func connect(
        to subscription: Sentinel_Subscription_V1_Subscription,
        completion: @escaping (Result<UInt64, Error>) -> Void
    ) {
        stopActiveSessions { [weak self] isSuccess in
            guard let self = self else { return }
            log.debug("Active sessions are stopped: \(isSuccess). Try to start a new one anyway")
            let startMessage = Sentinel_Session_V1_MsgStartRequest.with {
                $0.id = subscription.id
                $0.from = self.walletService.accountAddress
                $0.node = subscription.node
            }

            let anyMessage = Google_Protobuf2_Any.with {
                $0.typeURL = "/sentinel.session.v1.MsgService/MsgStart"
                $0.value = try! startMessage.serializedData()
            }

            self.generateAndBroadcast(to: subscription.node, messages: [anyMessage]) { isSuccess in
                guard isSuccess else {
                    log.error("Failed to start a session")
                    completion(.failure(SentinelServiceError.broadcastFailed))
                    return
                }

                self.loadActiveSession(completion: completion)
            }
        }
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
                guard let sessionID = sessions.first?.id else {
                    log.error("Failed to start a session: no id or empty array")
                    completion(.failure(SentinelServiceError.broadcastFailed))
                    return
                }
                completion(.success(sessionID))
            }
        }
    }

    public func connectToActiveSubscription(completion: @escaping (Result<UInt64, Error>) -> Void) {
        // fetch account subscriptions
        provider.fetchSubscriptions(for: walletService.accountAddress) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let subscriptions):
                if let subscription = subscriptions.first {
                    self?.connect(to: subscription, completion: completion)
                }
            }
        }
    }

    func generateAndBroadcast(
        to node: String,
        messages: [Google_Protobuf2_Any],
        completion: @escaping (Bool) -> Void
    ) {
        walletService.generateSignedRequest(to: node, messages: messages) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion(false)

            case .success(let request):
                self?.broadcast(request: request, completion: completion)
            }
        }
    }

    func broadcast(request: Cosmos_Tx_V1beta1_BroadcastTxRequest, completion: @escaping (Bool) -> Void) {
        provider.broadcastGrpcTx(signedRequest: request) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                completion(false)

            case .success(let response):
                log.debug(response)
                completion(true)
            }
        }
    }

    func stopActiveSessions(completion: @escaping (Bool) -> Void) {
        provider.loadActiveSessions(for: walletService.accountAddress) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                log.error(error)
                completion(false)

            case .success(let sessions):
                log.debug(sessions)

                guard !sessions.isEmpty else {
                    completion(true)
                    return
                }

                guard let node = sessions.first?.node else {
                    completion(false)
                    return
                }

                let messages = sessions.map { session in
                    Sentinel_Session_V1_MsgEndRequest.with {
                        $0.id = session.id
                        $0.from = self.walletService.accountAddress
                    }}.map { stopMessage in
                        Google_Protobuf2_Any.with {
                            $0.typeURL = "/sentinel.session.v1.MsgService/MsgEnd"
                            $0.value = try! stopMessage.serializedData()
                        }
                    }

                self.generateAndBroadcast(to: node, messages: messages, completion: completion)
            }
        }
    }
}
