//
//  AsyncSubscriptionsProvider.swift
//
//
//  Created by Lika Vorobeva on 20.10.2023.
//

import Foundation
import GRPC
import NIO

public protocol AsyncSubscriptionsProviderType {
    func fetchBalance(for wallet: String) async throws -> String
    func fetchSubscriptions(limit: UInt64, offset: UInt64, for wallet: String) async throws -> String
    func fetchSessions(for wallet: String) async throws -> String?
    func fetchGrants(for wallet: String, granter: String) async throws -> String
}

public protocol TypedSubscriptionsProviderType {
    func fetchBalance(for wallet: String) async throws -> [Cosmos_Base_V1beta1_Coin]
    func fetchSubscriptions(limit: UInt64, offset: UInt64, for wallet: String) async throws -> Sentinel_Subscription_V3_QuerySubscriptionsForAccountResponse
    func fetchSessions(for wallet: String) async throws -> UInt64?
}

// MARK: - AsyncSubscriptionsProvider

final public class AsyncSubscriptionsProvider {
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

extension AsyncSubscriptionsProvider: ConfigurableProvider {
    public func set(host: String, port: Int) {
        configuration = .init(host: host, port: port)
    }
}

// MARK: - AsyncSubscriptionsProviderType

extension AsyncSubscriptionsProvider: AsyncSubscriptionsProviderType {
    public func fetchBalance(for wallet: String) async throws -> String {
        try await fetchBalance(for: wallet).jsonString()
    }
    
    public func fetchGrants(for wallet: String, granter: String) async throws -> String {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer { try? channel.close().wait()}
        
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.seconds(5))
        
        
        let request = Cosmos_Feegrant_V1beta1_QueryAllowanceRequest.with {
            $0.grantee = wallet
            $0.granter = granter
        }
        
        let client = Cosmos_Feegrant_V1beta1_QueryAsyncClient(channel: channel)
        let result = try await client.allowance(request, callOptions: callOptions)
        return try result.jsonString()
    }
    
    public func fetchSubscriptions(limit: UInt64, offset: UInt64, for wallet: String) async throws -> String {
        try await fetchSubscriptions(limit: limit, offset: offset, for: wallet).jsonString()
    }
    
    public func fetchSessions(for wallet: String) async throws -> String? {
        try await fetchSessions(for: wallet)?.jsonString()
    }
}

// MARK: - TypedSubscriptionsProviderType

extension AsyncSubscriptionsProvider: TypedSubscriptionsProviderType {
    public func fetchBalance(for wallet: String) async throws -> [Cosmos_Base_V1beta1_Coin] {
        try await fetchBalance(for: wallet).balances
    }
    
    public func fetchSubscriptions(
        limit: UInt64, offset: UInt64,
        for wallet: String
    ) async throws -> Sentinel_Subscription_V3_QuerySubscriptionsForAccountResponse {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer { try? channel.close().wait()}
        
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        
        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
            $0.limit = limit
            $0.offset = offset
        }
        
        let request = Sentinel_Subscription_V3_QuerySubscriptionsForAccountRequest.with {
            $0.address = wallet
            $0.pagination = page
        }
        
        let client = Sentinel_Subscription_V3_QueryServiceAsyncClient(channel: channel)
        let response = try await client.querySubscriptionsForAccount(request, callOptions: callOptions)
        
        return response
    }
    
    public func fetchSessions(for wallet: String) async throws -> UInt64? {
        try await fetchSessions(for: wallet)?.id
    }
}

// MARK: - Private

private extension AsyncSubscriptionsProvider {
    func fetchBalance(for wallet: String) async throws -> Cosmos_Bank_V1beta1_QueryAllBalancesResponse {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer { try? channel.close().wait() }
        
        let req = Cosmos_Bank_V1beta1_QueryAllBalancesRequest.with { $0.address = wallet }
        let client = Cosmos_Bank_V1beta1_QueryAsyncClient(channel: channel)
        
        return try await client.allBalances(req, callOptions: callOptions)
    }
    
    func fetchSessions(for wallet: String) async throws -> Sentinel_Session_V3_BaseSession? {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer { try? channel.close().wait()}
        
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        
        let request = Sentinel_Session_V3_QuerySessionsForAccountRequest.with { $0.address = wallet }
        
        let client = Sentinel_Session_V3_QueryServiceAsyncClient(channel: channel)
        let result = try await client.querySessionsForAccount(request, callOptions: callOptions)
        let session = result.sessions
            .compactMap { try? Sentinel_Session_V3_BaseSession(serializedData: $0.value) }
        
        return session.first(where: { $0.status == .active || $0.status == .unspecified })
    }
}
