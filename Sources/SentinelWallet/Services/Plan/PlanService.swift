//
//  PlanService.swift
//  SentinelWallet
//
//  Created by Victoria Kostyleva on 18.03.2022.
//

import Foundation

final public class PlanService {
    private let provider: SentinelProviderType

    public init(host: String, port: Int) {
        provider = SentinelProvider(host: host, port: port)
    }
}

extension PlanService {
    public func queryProviders(
        offset: UInt64 = 0,
        limit: UInt64 = 0,
        completion: @escaping (Result<[SentinelNodesProvider], Error>) -> Void
    ) {
        provider.fetchProviders(offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let providers):
                completion(.success(providers.map { SentinelNodesProvider.init(from: $0) }))
            }
        }
    }
    
    public func queryPlans(
        offset: UInt64 = 0,
        limit: UInt64 = 1000,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    ) {
        provider.fetchPlans(offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let plans):
                completion(.success(plans.map(SentinelPlan.init)))
            }
        }
    }
    
    public func queryPlans(
        for providerAddress: String,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    ) {
        provider.fetchPlans(for: providerAddress) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let plans):
                completion(.success(plans.map(SentinelPlan.init)))
            }
        }
    }
    
    public func queryNodesForPlan(
        with id: UInt64,
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        provider.fetchNodes(for: id) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                let sentinelNodes = nodes.map { SentinelNode(from: $0) }
                completion(.success(sentinelNodes))
            }
        }
    }
}
