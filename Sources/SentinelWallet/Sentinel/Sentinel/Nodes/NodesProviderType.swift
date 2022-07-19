//
//  NodesProviderType.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public protocol NodesProviderType {
    func fetchAvailableNodes(
        offset: UInt64,
        limit: UInt64,
        allowedDenoms: [String],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    )

    func queryNodes(
        offset: UInt64,
        limit: UInt64,
        allowedDenoms: [String],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    )
    
    func queryInfo(
        for sentinelNode: SentinelNode,
        timeout: TimeInterval,
        completion: @escaping (Result<Node, Error>) -> Void
    )
    
    func queryNodeStatus(
        address: String,
        timeout: TimeInterval,
        completion: @escaping (Result<SentinelNode, Error>) -> Void
    )
}
