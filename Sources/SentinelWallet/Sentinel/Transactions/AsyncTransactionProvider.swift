//
//  AsyncTransactionProvider.swift
//
//
//  Created by Lika Vorobeva on 20.10.2023.
//

import Foundation
import GRPC
import NIO
import HDWallet
import SwiftProtobuf

private struct Constants {
    let sendMessageURL = "/cosmos.bank.v1beta1.MsgSend"
    
    let subscribeToNodeURL = "/sentinel.node.v2.MsgSubscribeRequest"
    let subscribeToPlanURL = "/sentinel.plan.v2.MsgSubscribeRequest"
}

private let constants = Constants()

public protocol AsyncTransactionProviderType {
    func subscribe(
        sender: TransactionSender,
        node: String,
        details: NodePaymentDetails,
        fee: Fee
    ) async throws -> String
    
    func subscribe(
        sender: TransactionSender,
        plan: UInt64,
        details: PlanPaymentDetails,
        fee: Fee
    ) async throws -> String
    
    func transfer(
        sender: TransactionSender,
        recipient: String,
        details: DirectPaymentDetails,
        fee: Fee
    ) async throws -> String
}

final public class AsyncTransactionProvider {
    private let connectionProvider: AsyncClientConnectionProviderType
    private var configuration: ClientConnectionConfiguration
    
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }
    
    public init(config: ClientConnectionConfiguration = .init()) {
        self.connectionProvider = AsyncClientConnectionProvider()
        self.configuration = config
    }
}

// MARK: - ConfigurableProvider

extension AsyncTransactionProvider: ConfigurableProvider {
    public func set(host: String, port: Int) {
        configuration = .init(host: host, port: port)
    }
}

// MARK: - AsyncTransactionProviderType

extension AsyncTransactionProvider: AsyncTransactionProviderType {
    public func subscribe(
        sender: TransactionSender,
        node: String,
        details: NodePaymentDetails,
        fee: Fee
    ) async throws -> String {
        let startMessage = Sentinel_Node_V2_MsgSubscribeRequest.with {
            $0.from = sender.owner
            $0.nodeAddress = node
            $0.gigabytes = details.gigabytes
            $0.hours = details.hours
            $0.denom = details.denom
        }
        
        let anyMessage = Google_Protobuf_Any.with {
            $0.typeURL = constants.subscribeToNodeURL
            $0.value = try! startMessage.serializedData()
        }
        
        return try await broadcast(sender: sender, recipient: node, messages: [anyMessage], fee: fee).jsonString()
    }    
    
    public func subscribe(
        sender: TransactionSender,
        plan: UInt64,
        details: PlanPaymentDetails,
        fee: Fee
    ) async throws -> String {
        let startMessage = Sentinel_Plan_V2_MsgSubscribeRequest.with {
            $0.from = sender.owner
            $0.id = plan
            $0.denom = details.denom
        }
        
        let anyMessage = Google_Protobuf_Any.with {
            $0.typeURL = constants.subscribeToPlanURL
            $0.value = try! startMessage.serializedData()
        }
        
        return try await broadcast(sender: sender, recipient: details.address, messages: [anyMessage], fee: fee).jsonString()
    }    
    
    public func transfer(
        sender: TransactionSender,
        recipient: String,
        details: DirectPaymentDetails,
        fee: Fee
    ) async throws -> String {
        let sendCoin = Cosmos_Base_V1beta1_Coin.with {
            $0.denom = details.denom
            $0.amount = details.amount
        }
        
        let sendMessage = Cosmos_Bank_V1beta1_MsgSend.with {
            $0.fromAddress = sender.owner
            $0.toAddress = recipient
            $0.amount = [sendCoin]
        }
        
        let anyMessage = Google_Protobuf_Any.with {
            $0.typeURL = constants.sendMessageURL
            $0.value = try! sendMessage.serializedData()
        }
        
        return try await broadcast(
            sender: sender,
            recipient: recipient,
            messages: [anyMessage],
            memo: details.memo,
            fee: fee
        ).jsonString()
    }
}

// MARK: - Private methods

extension AsyncTransactionProvider {
    private func fetchAuthorization(for address: String) async throws -> Google_Protobuf_Any {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        
        let request = Cosmos_Auth_V1beta1_QueryAccountRequest.with { $0.address = address }
        let client = Cosmos_Auth_V1beta1_QueryAsyncClient(channel: channel)
        
        return try await client.account(request, callOptions: self.callOptions).account
    }
    
    private func broadcast(
        sender: TransactionSender,
        recipient: String,
        messages: [Google_Protobuf_Any],
        memo: String? = nil,
        fee: Fee
    ) async throws -> Cosmos_Base_Abci_V1beta1_TxResponse {
        guard recipient != sender.owner else { throw TransactionError.accountMatchesDestination }
        
        let accountGRPC = try await fetchAuthorization(for: sender.owner)
        
        let request = Signer.generateSignedRequest(
            with: accountGRPC,
            to: recipient,
            fee: fee,
            for: messages,
            memo: memo ?? "",
            mnemonic: sender.ownerMnemonic,
            chainId: sender.chainID
        )
        
        return try await broadcastGrpcTx(signedRequest: request)
    }
    
    private func broadcastGrpcTx(
        signedRequest: Cosmos_Tx_V1beta1_BroadcastTxRequest
    ) async throws -> Cosmos_Base_Abci_V1beta1_TxResponse {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        return try await Cosmos_Tx_V1beta1_ServiceAsyncClient(channel: channel).broadcastTx(signedRequest).txResponse
    }
}
///// Cancel any type of subscription (to a node or to a plan)
//public func cancel(
//    subscriptions: [UInt64],
//    sender: TransactionSender,
//    node: String,
//    completion: @escaping (Result<TransactionResult, Error>) -> Void
//) {
//    let messages = subscriptions.map { subscriptionID -> Google_Protobuf_Any in
//        let startMessage = Sentinel_Subscription_V2_MsgCancelRequest.with {
//            $0.id = subscriptionID
//            $0.from = sender.owner
//        }
//
//        let anyMessage = Google_Protobuf_Any.with {
//            $0.typeURL = constants.cancelSubscriptionURL
//            $0.value = try! startMessage.serializedData()
//        }
//        
//        return anyMessage
//    }
//    
//    transactionProvider.broadcast(
//        sender: sender,
//        recipient: node,
//        messages: messages,
//        gasFactor: subscriptions.count,
//        completion: completion
//    )
//}
//}

//// MARK: - Sessions
//
//extension SubscriptionsProvider {
//public func startNewSession(
//    on subscriptionID: UInt64,
//    activeSession: UInt64?,
//    sender: TransactionSender,
//    node: String,
//    completion: @escaping (Result<Bool, Error>) -> Void
//) {
//    let stopMessage = formStopMessage(activeSession: activeSession, sender: sender)
//    let startMessage = Sentinel_Session_V2_MsgStartRequest.with {
//        $0.id = subscriptionID
//        $0.from = sender.owner
//        $0.address = node
//    }
//    
//    let anyMessage = Google_Protobuf_Any.with {
//        $0.typeURL = constants.startSessionURL
//        $0.value = try! startMessage.serializedData()
//    }
//    
//    let messages = stopMessage + [anyMessage]
//    
//    transactionProvider.broadcast(
//        sender: sender,
//        recipient: node,
//        messages: messages,
//        gasFactor: 0
//    ) { result in
//        let mapped =  result.map { $0.isSuccess }
//        completion(mapped)
//    }
//}
//
//public func stop(
//    activeSession: UInt64,
//    node: String,
//    sender: TransactionSender,
//    completion: @escaping (Result<Bool, Error>) -> Void
//) {
//    let stopMessage = formStopMessage(activeSession: activeSession, sender: sender)
//    transactionProvider.broadcast(
//        sender: sender,
//        recipient: node,
//        messages: stopMessage,
//        gasFactor: 0
//    ) { result in
//        let mapped =  result.map { $0.isSuccess }
//        completion(mapped)
//    }
//}
//
//private func formStopMessage(activeSession: UInt64?, sender: TransactionSender) -> [Google_Protobuf_Any] {
//    guard let activeSession = activeSession else { return [] }
//    let stopMessage = Sentinel_Session_V2_MsgEndRequest.with {
//        $0.id = activeSession
//        $0.from = sender.owner
//    }
//    let anyMessage = Google_Protobuf_Any.with {
//        $0.typeURL = constants.stopSessionURL
//        $0.value = try! stopMessage.serializedData()
//    }
//    return [anyMessage]
//}
//}
