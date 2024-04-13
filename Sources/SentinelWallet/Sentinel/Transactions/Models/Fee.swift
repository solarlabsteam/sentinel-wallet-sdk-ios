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
    var granter: String? = nil

    enum CodingKeys: String, CodingKey {
        case gas
        case tokens = "amount"
    }

    public init(_ gas: String, _ amount: [CoinToken], granter: String? = nil) {
        self.gas = gas
        self.tokens = amount
        self.granter = granter
    }
    
    public init(for gas: Int, granter: String? = nil) {
        self.init(
            String(gas * 10),
            [.init(denom: GlobalConstants.denom, amount: String(gas))],
            granter: granter
        )
    }
}

extension Fee {
    static var standart: Fee = .init(for: 30_000)
}
