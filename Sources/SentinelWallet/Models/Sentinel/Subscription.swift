//
//  Subscription.swift
//  
//
//  Created by Lika Vorobyeva on 26.07.2021.
//

import Foundation

public struct Subscription {
    public let id: UInt64
    public let owner: String
    public let node: String

    public let price: CoinToken
    public let deposit: CoinToken

    public let plan: UInt64
    public let denom: String

    public let isActive: Bool

    init(from sentinelSubscription: Sentinel_Subscription_V1_Subscription) {
        id = sentinelSubscription.id
        owner = sentinelSubscription.owner
        node = sentinelSubscription.node
        price = CoinToken(from: sentinelSubscription.price)
        deposit = CoinToken(from: sentinelSubscription.deposit)
        plan = sentinelSubscription.plan
        denom = sentinelSubscription.denom
        isActive = sentinelSubscription.status == .active
    }
}
