//
//  Price.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 26.06.2021.
//

import Foundation

public struct ExchangeRates: Codable {
    let denom: String
    let lastUpdated: String
    let prices: [Prices]

    enum CodingKeys: String, CodingKey {
        case denom
        case lastUpdated = "last_updated"
        case prices
    }
}

public struct Prices: Codable {
    var currency: String
    var currentPrice: Double
    var dailyPriceChangePercentage: Double

    enum CodingKeys: String, CodingKey  {
        case currency = "currency"
        case currentPrice = "current_price"
        case dailyPriceChangePercentage = "daily_price_change_in_percentage"
    }
}
