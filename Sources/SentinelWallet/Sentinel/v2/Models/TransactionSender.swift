//
//  TransactionSender.swift
//  
//
//  Created by Lika Vorobeva on 20.10.2023.
//

import Foundation

public struct TransactionSender {
    public let owner: String
    public let ownerMnemonic: [String]
    let chainID: String

    public init(owner: String, ownerMnemonic: [String], chainID: String) {
        self.owner = owner
        self.ownerMnemonic = ownerMnemonic
        self.chainID = chainID
    }
}
