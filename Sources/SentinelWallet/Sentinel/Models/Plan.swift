//
//  Plan.swift
//  
//
//  Created by Lika Vorobeva on 10.02.2022.
//

import Foundation

public struct SentinelPlan {
    public let id: UInt64
    public let provider: String
    public let price: [CoinToken]

    public let bytes: Int64

    public let isActive: Bool
    
    init(from plan: Sentinel_Plan_V2_Plan) {
        id = plan.id
        provider = plan.providerAddress
        price = plan.prices.map(CoinToken.init)
        bytes = plan.gigabytes
        isActive = plan.status == .active
    }
}
