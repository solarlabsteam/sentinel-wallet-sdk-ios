//
//  CoinToken.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation

public struct CoinToken: Codable {
    public var denom: String
    public var amount: String

    enum CodingKeys: String, CodingKey {
        case denom
        case amount
    }

    public init(denom: String, amount: String) {
        self.denom = denom
        self.amount = amount
    }

    init(from coin: Cosmos_Base_V1beta1_Coin) {
        self.init(denom: coin.denom, amount: coin.amount)
    }
}
