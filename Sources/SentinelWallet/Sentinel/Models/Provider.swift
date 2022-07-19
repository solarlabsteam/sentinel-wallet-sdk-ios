//
//  Provider.swift
//  
//
//  Created by Lika Vorobeva on 10.02.2022.
//

import Foundation

public struct SentinelNodesProvider {
    public let address: String
    public let name: String
    public let identity: String
    public let website: String
    public let description: String
    
    init(from provider: Sentinel_Provider_V1_Provider) {
        address = provider.address
        name = provider.name
        identity = provider.identity
        website = provider.website
        description = provider.description_p
    }
}
