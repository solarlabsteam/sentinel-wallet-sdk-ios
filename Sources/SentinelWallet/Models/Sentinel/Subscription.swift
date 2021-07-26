//
//  Subscription.swift
//  
//
//  Created by Lika Vorobyeva on 26.07.2021.
//

import Foundation

public struct Subscription {
    let id: UInt64
    let owner: String
    let node: String

    let price: CoinToken
    let deposit: CoinToken

    let plan: UInt64
    let denom: String

    let isActive: Bool

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
