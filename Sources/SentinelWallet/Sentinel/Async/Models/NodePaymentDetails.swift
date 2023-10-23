//
//  PaymentDetails.swift
//
//
//  Created by Lika Vorobeva on 23.10.2023.
//

import Foundation

public struct NodePaymentDetails {
    public let denom: String
    public let gigabytes: Int64
    public let hours: Int64
    
    public init(denom: String, gigabytes: Int64 = 0, hours: Int64 = 0) {
        self.denom = denom
        self.gigabytes = gigabytes
        self.hours = hours
    }
}

extension NodePaymentDetails: Codable {}

public struct PlanPaymentDetails {
    public let address: String
    public let denom: String
    
    public init(address: String, denom: String) {
        self.address = address
        self.denom = denom
    }
}

extension PlanPaymentDetails: Codable {}
