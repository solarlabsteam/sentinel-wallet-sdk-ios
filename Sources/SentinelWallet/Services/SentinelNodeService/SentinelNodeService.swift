//
//  SentinelNodeService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

final public class SentinelNodeService {
    private let provider: SentinelProviderType
    
    public init() {
        provider = SentinelProvider()
    }
    
    public func queryNodes(
        offset: UInt64 = 0,
        limit: UInt64 = 0,
        allowedDenoms: [String] = [GlobalConstants.denom],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        provider.fetchAvailableNodes(offset: offset, limit: limit, allowedDenoms: allowedDenoms) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                completion(.success(nodes))
            }
        }
    }
    
    public func queryInfo(
        for sentinelNode: SentinelNode,
        timeout: TimeInterval,
        completion: @escaping (Result<Node, Error>) -> Void
    ) {
        self.provider.fetchInfo(for: sentinelNode.remoteURL, timeout: timeout) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodeResult):
                guard nodeResult.0.success, let nodeInfo = nodeResult.0.result else {
                    log.error("Failed to get info")
                    return
                }
                
                let node = Node(info: nodeInfo, latency: nodeResult.1)
                completion(.success(node))
            }
        }
    }
    
    public func queryNodeStatus(
        address: String,
        timeout: TimeInterval,
        completion: @escaping (Result<SentinelNode, Error>) -> Void
    ) {
        provider.fetchNode(address: address) { [weak self] result in
            guard let self = self else {
                completion(.failure(SentinelServiceError.emptyInfo))
                return
            }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let sentinelNodeV1Node):
                self.provider.fetchInfo(for: sentinelNodeV1Node.remoteURL, timeout: timeout) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let info):
                        guard info.0.success, let result = info.0.result else {
                            completion(.failure(SentinelServiceError.emptyInfo))
                            return
                        }
                        
                        let node = Node(info: result, latency: info.1)
                        completion(.success(.init(from: sentinelNodeV1Node, node: node)))
                    }
                }
            }
        }
    }
}
