//
//  Price.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 26.06.2021.
//

import Foundation

public struct ExchangeRates: Codable {
    public let denom: String
    public let lastUpdated: String
    public let prices: [Prices]

    enum CodingKeys: String, CodingKey {
        case denom
        case lastUpdated = "last_updated"
        case prices
    }
}

public struct Prices: Codable {
    public var currency: String
    public var currentPrice: Double
    public var dailyPriceChangePercentage: Double

    enum CodingKeys: String, CodingKey  {
        case currency
        case currentPrice = "current_price"
        case dailyPriceChangePercentage = "daily_price_change_in_percentage"
    }
}
