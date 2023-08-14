//
//  Allocation.swift
//  
//
//  Created by Lika Vorobyeva on 07.08.2021.
//

import Foundation

public struct Allocation: Codable {
    public let address: String
    public let allocated: String
    public let consumed: String

    init(from allocation: Sentinel_Subscription_V2_Allocation) {
        self.address = allocation.address
        self.allocated = allocation.grantedBytes
        self.consumed = allocation.utilisedBytes
    }
}
