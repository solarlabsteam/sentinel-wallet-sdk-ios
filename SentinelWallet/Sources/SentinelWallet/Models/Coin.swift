//
//  Coin.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation

public struct Coin: Codable {
    var denom: String
    var amount: String

    enum CodingKeys: String, CodingKey {
        case denom
        case amount
    }
}
