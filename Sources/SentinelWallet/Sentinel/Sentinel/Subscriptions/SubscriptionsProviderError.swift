//
//  SubscriptionsProviderError.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public enum SubscriptionsProviderError: Error {
    case broadcastFailed
    case nonNodeSubscription
    case sessionStartFailed
    case sessionsStopFailed
}
