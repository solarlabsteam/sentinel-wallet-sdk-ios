//
//  NodeSubscription.swift
//  
//
//  Created by Lika Vorobyeva on 26.07.2021.
//

import Foundation
import SwiftProtobuf

public struct NodeSubscription {
    public let base: SubscriptionBase
    public let node: String

    public let gigabytes: Int64
    public let hours: Int64

    public let deposit: CoinToken

    init(from sentinelSubscription: Sentinel_Subscription_V2_NodeSubscription) {
        base = .init(from: sentinelSubscription.base)
        node = sentinelSubscription.nodeAddress
        gigabytes = sentinelSubscription.gigabytes
        hours = sentinelSubscription.hours
        deposit = CoinToken(from: sentinelSubscription.deposit)
    }

    init?(from any: Google_Protobuf_Any) {
        guard let sentinelSubscription = try? Sentinel_Subscription_V2_NodeSubscription(serializedData: any.value) else {
            return nil
        }

        self.init(from: sentinelSubscription)
    }
}

public struct SubscriptionBase {
    public let id: UInt64
    public let owner: String
    public let isActive: Bool

    init(from base: Sentinel_Subscription_V2_BaseSubscription) {
        id = base.id
        owner = base.address
        isActive = base.status == .active
    }
}
