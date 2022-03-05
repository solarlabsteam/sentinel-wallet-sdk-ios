//
//  SubscriptionStatus.swift
//  
//
//  Created by Victoria Kostyleva on 04.03.2022.
//

import Foundation

public enum SubscriptionStatus: Int {
    case unspecified
    case active
    case inactivePending
    case inactive
}

extension Sentinel_Types_V1_Status {
    init?(from subscriptionStatus: SubscriptionStatus) {
        self.init(rawValue: subscriptionStatus.rawValue)
    }
}
