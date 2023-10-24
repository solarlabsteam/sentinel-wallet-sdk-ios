//
//  AsyncNodesProvider.swift
//
//
//  Created by Lika Vorobeva on 18.10.2023.
//

import Foundation
import GRPC
import NIO

public protocol AsyncNodesProviderType {
    func getActiveNodes(limit: UInt64, offset: UInt64) async throws -> [String]
    func getActiveNodes(for planID: UInt64, limit: UInt64, offset: UInt64) async throws -> [String]
    func getPlans(limit: UInt64, offset: UInt64) async throws -> [String]
}

final public class AsyncNodesProvider {
    private let connectionProvider: AsyncClientConnectionProviderType
    private var configuration: ClientConnectionConfiguration
    
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }
    
    public init(config: ClientConnectionConfiguration = .init()) {
        self.connectionProvider = AsyncClientConnectionProvider()
        self.configuration = config
    }
}


// MARK: - ConfigurableProvider

extension AsyncNodesProvider: ConfigurableProvider {
    public func set(host: String, port: Int) {
        configuration = .init(host: host, port: port)
    }
}

// MARK: - AsyncNodesProviderType

extension AsyncNodesProvider: AsyncNodesProviderType {
    public func getActiveNodes(limit: UInt64, offset: UInt64) async throws -> [String] {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        
        let nodeClient = Sentinel_Node_V2_QueryServiceAsyncClient(channel: channel)
    
        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
            $0.limit = limit
            $0.offset = offset
        }
        let request = Sentinel_Node_V2_QueryNodesRequest.with {
            $0.status = .active
            $0.pagination = page
        }
        
        return try await nodeClient.queryNodes(request).nodes.compactMap { try? $0.jsonString() }
    }
       
    public func getActiveNodes(for planID: UInt64, limit: UInt64, offset: UInt64) async throws -> [String] {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        
        let nodeClient = Sentinel_Node_V2_QueryServiceAsyncClient(channel: channel)
        
        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
            $0.limit = limit
            $0.offset = offset
        }
        let request = Sentinel_Node_V2_QueryNodesForPlanRequest.with {
            $0.id = planID
            $0.status = .active
            $0.pagination = page
        }
        
        return try await nodeClient.queryNodesForPlan(request).nodes.compactMap { try? $0.jsonString() }
    }
    
    public func getPlans(limit: UInt64, offset: UInt64) async throws -> [String] {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        
        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
            $0.limit = limit
            $0.offset = offset
        }
        let request = Sentinel_Plan_V2_QueryPlansRequest.with {
            $0.pagination = page
            $0.status = .active
        }
        
        let planClient =  Sentinel_Plan_V2_QueryServiceAsyncClient(channel: channel)
        return try await planClient.queryPlans(request).plans.compactMap { try? $0.jsonString() }
    }
}
