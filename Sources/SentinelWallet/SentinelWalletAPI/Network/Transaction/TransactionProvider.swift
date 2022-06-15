//
//  TransactionProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 15.07.2021.
//

import Foundation
import GRPC
import NIO

protocol TransactionProviderType {
    func broadcastGrpcTx(
        signedRequest: Cosmos_Tx_V1beta1_BroadcastTxRequest,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    )
}

final class TransactionProvider: TransactionProviderType {
    private let connectionProvider: ClientConnectionProviderType

    init(
        host: String,
        port: Int
    ) {
        self.connectionProvider = ClientConnectionProvider(host: host, port: port)
    }

    func broadcastGrpcTx(
        signedRequest: Cosmos_Tx_V1beta1_BroadcastTxRequest,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let response = try Cosmos_Tx_V1beta1_ServiceClient(channel: channel)
                    .broadcastTx(signedRequest)
                    .response
                    .wait()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        })
    }
}
