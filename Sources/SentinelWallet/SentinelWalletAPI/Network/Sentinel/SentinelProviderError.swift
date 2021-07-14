//
//  SentinelProviderError.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

enum SentinelProviderError: LocalizedError {
    case invalidHost(urlString: String)

    var errorDescription: String? {
        switch self {
        case .invalidHost(let url):
            return "Failed to get host for \(url)"
        }
    }
}
