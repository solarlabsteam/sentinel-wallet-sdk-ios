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

    public let validity: TimeInterval
    public let bytes: String

    public let isActive: Bool
    
    init(from plan: Sentinel_Plan_V1_Plan) {
        id = plan.id
        provider = plan.provider
        price = plan.price.map(CoinToken.init)
        validity = plan.validity.timeInterval
        bytes = plan.bytes
        isActive = plan.status == .active
    }
}
