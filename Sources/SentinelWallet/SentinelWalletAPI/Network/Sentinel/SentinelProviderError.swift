//
//  SentinelProviderError.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

public enum SentinelProviderError: LocalizedError {
    case invalidHost(urlString: String)

    public var errorDescription: String? {
        switch self {
        case .invalidHost(let url):
            return "Failed to get host for \(url)"
        }
    }
}
