//
//  Fee.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 02.07.2021.
//

import Foundation

public struct Fee: Codable {
    var gas: String = ""
    var tokens: [CoinToken] = []

    enum CodingKeys: String, CodingKey {
        case gas
        case tokens = "amount"
    }

    public init(_ gas: String, _ amount: [CoinToken] ) {
        self.gas = gas
        self.tokens = amount
    }
    
    public init(for gas: Int) {
        self.init(String(gas * 10), [.init(denom: GlobalConstants.denom, amount: String(gas))])
    }
}
