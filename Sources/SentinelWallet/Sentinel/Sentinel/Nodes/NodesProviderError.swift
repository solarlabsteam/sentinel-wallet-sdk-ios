//
//  NodesProviderError.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public enum NodesProviderError: LocalizedError {
    case invalidHost(urlString: String)
    case emptyInfo

    public var errorDescription: String? {
        switch self {
        case .invalidHost(let url):
            return "Failed to get host for \(url)"
        case .emptyInfo:
            return "Empty node info"
        }
    }
}
