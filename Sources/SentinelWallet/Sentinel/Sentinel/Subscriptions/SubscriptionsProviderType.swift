//
//  SubscriptionsProviderType.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public protocol SubscriptionsProviderType {
    func queryQuota(
        address: String,
        subscriptionId: UInt64,
        completion: @escaping (Result<Quota, Error>) -> Void
    )
    
    func subscribe(
        transactionData: TransactionData,
        deposit: CoinToken,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    )
    
    func cancel(
        subscriptions: [UInt64],
        transactionData: TransactionData,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    )
    
    func querySubscription(
        with id: UInt64,
        completion: @escaping (Result<Subscription, Error>) -> Void
    )
    
    func querySubscriptions(
        for account: String,
        with status: SubscriptionStatus,
        completion: @escaping (Result<[Subscription], Error>) -> Void
    )
    
    func startNewSession(
        on subscriptionID: UInt64,
        data: TransactionData,
        completion: @escaping (Result<UInt64, Error>) -> Void
    )
    
    func queryActiveSessions(for account: String, completion: @escaping (Result<[Session], Error>) -> Void)
    
    func stopActiveSessions(
        transactionData: TransactionData,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}
