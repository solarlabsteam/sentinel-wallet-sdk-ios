//
//  SentinelService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

final public class SentinelService {
    private let provider: SentinelProviderType

    public init() {
        provider = SentinelProvider()
    }

    public func fetchAvailableNodes() {
        provider.fetchAvailableNodes(offset: 0) { result in
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let nodes):
                log.debug("Loaded nodes: \(nodes.count)")
                log.debug(nodes.map { "\($0.key.address) : \($0.value.address)" })
            }
        }
    }
}
