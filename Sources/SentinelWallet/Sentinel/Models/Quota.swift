//
//  Quota.swift
//  
//
//  Created by Lika Vorobyeva on 07.08.2021.
//

import Foundation

public struct Quota: Codable {
    public let address: String
    public let allocated: String
    public let consumed: String

    init(from quota: Sentinel_Subscription_V1_Quota) {
        self.address = quota.address
        self.allocated = quota.allocated
        self.consumed = quota.consumed
    }
}
