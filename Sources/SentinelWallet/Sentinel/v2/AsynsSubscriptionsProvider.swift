//
//  AsynsSubscriptionsProvider.swift
//  
//
//  Created by Lika Vorobeva on 20.10.2023.
//

import Foundation
import GRPC
import NIO

public protocol AsynsSubscriptionsProviderType {
    func set(host: String, port: Int)
    
    func fetchBalance(for wallet: String) async throws -> [String]
    func fetchSubscriptions(limit: UInt64, offset: UInt64, for wallet: String) async throws -> [String]
}

final public class AsynsSubscriptionsProvider {
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

extension AsynsSubscriptionsProvider: AsynsSubscriptionsProviderType {
    public func set(host: String, port: Int) {
        self.configuration = .init(host: host, port: port)
    }
    
    public func fetchBalance(for wallet: String) async throws -> [String] {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        
        let req = Cosmos_Bank_V1beta1_QueryAllBalancesRequest.with {
            $0.address = wallet
        }

        let client = Cosmos_Bank_V1beta1_QueryAsyncClient(channel: channel)
        
        return try await client.allBalances(req, callOptions: callOptions).balances.compactMap { try? $0.jsonString() }
    }    
    
    public func fetchSubscriptions(limit: UInt64, offset: UInt64, for wallet: String) async throws -> [String] {
        let channel = connectionProvider.channel(for: configuration.host, port: configuration.port)
        defer {
            try? channel.close().wait()
        }
        
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))

        let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
            $0.limit = limit
            $0.offset = offset
        }
        
        let request = Sentinel_Subscription_V2_QuerySubscriptionsForAccountRequest.with {
            $0.address = wallet
            $0.pagination = page
        }
        
        let client = Sentinel_Subscription_V2_QueryServiceAsyncClient(channel: channel)
        
        return try await client.querySubscriptionsForAccount(request, callOptions: callOptions)
            .subscriptions
            .compactMap { anySubscription in
                if let value = try? Sentinel_Subscription_V2_NodeSubscription(serializedData: anySubscription.value) {
                    return try? value.jsonString()
                }
                return try? Sentinel_Subscription_V2_PlanSubscription(serializedData: anySubscription.value).jsonString()
            }
    }
}
