//
//  TransactionResult.swift
//  
//
//  Created by Lika Vorobyeva on 12.08.2021.
//

import Foundation

public struct TransactionResult {
    public let isSuccess: Bool
    public let timestamp: String
    public let txHash: String
    public let rawLog: String

    init(from response: Cosmos_Base_Abci_V1beta1_TxResponse) {
        isSuccess = response.code == 0
        timestamp = response.timestamp
        txHash = response.txhash
        rawLog = response.rawLog
    }
}
