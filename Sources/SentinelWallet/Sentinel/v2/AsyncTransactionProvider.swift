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
    let startSessionURL = "/sentinel.session.v2.MsgStartRequest"
    let stopSessionURL = "/sentinel.session.v2.MsgEndRequest"

    let subscribeToNodeURL = "/sentinel.node.v2.MsgSubscribeRequest"
    let cancelSubscriptionURL = "/sentinel.subscription.v2.MsgCancelRequest"
}

private let constants = Constants()

public protocol AsyncTransactionProviderType {
    func subscribe(
        sender: TransactionSender,
        node: String,
        denom: String,
        gigabytes: Int64,
        hours: Int64,
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
        denom: String,
        gigabytes: Int64,
        hours: Int64,
        fee: Fee
    ) async throws -> String {
        let startMessage = Sentinel_Node_V2_MsgSubscribeRequest.with {
            $0.from = sender.owner
            $0.nodeAddress = node
            $0.gigabytes = gigabytes
            $0.hours = hours
            $0.denom = denom
        }
        
        let anyMessage = Google_Protobuf_Any.with {
            $0.typeURL = constants.subscribeToNodeURL
            $0.value = try! startMessage.serializedData()
        }
        
        return try await broadcast(sender: sender, recipient: node, messages: [anyMessage], fee: fee).jsonString()
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
    ) async throws -> Cosmos_Tx_V1beta1_BroadcastTxResponse {
        guard recipient != sender.owner else { throw WalletServiceError.accountMatchesDestination }
        
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
    ) async throws -> Cosmos_Tx_V1beta1_BroadcastTxResponse {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        return try await Cosmos_Tx_V1beta1_ServiceAsyncClient(channel: channel).broadcastTx(signedRequest)
    }
}
