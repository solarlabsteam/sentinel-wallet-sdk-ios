//
//  PlansProviderType.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public protocol PlansProviderType {
    func subscribe(
        to planID: UInt64,
        denom: String,
        sender: TransactionSender,
        moniker: String,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    )
    
    func queryProviders(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[SentinelNodesProvider], Error>) -> Void
    )
    
    func queryPlans(
        offset: UInt64,
        limit: UInt64,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    )
    
    func queryPlans(
        for providerAddress: String,
        completion: @escaping (Result<[SentinelPlan], Error>) -> Void
    )
    
    func queryNodesForPlan(
        with id: UInt64,
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    )
}
