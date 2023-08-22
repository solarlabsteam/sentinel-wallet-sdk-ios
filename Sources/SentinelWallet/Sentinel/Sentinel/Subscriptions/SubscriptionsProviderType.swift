//
//  SubscriptionsProviderType.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public protocol SubscriptionsProviderType {
    func queryAllocation(
        address: String,
        subscriptionId: UInt64,
        completion: @escaping (Result<Allocation, Error>) -> Void
    )

    func subscribe(
        sender: TransactionSender,
        node: String,
        deposit: CoinToken,
        gigabytes: Int64,
        hours: Int64,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    )

    func cancel(
        subscriptions: [UInt64],
        sender: TransactionSender,
        node: String,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    )
    
    func queryNodeSubscription(
        with id: UInt64,
        completion: @escaping (Result<NodeSubscription, Error>) -> Void
    )

    func queryNodeSubscriptions(
        for account: String,
        completion: @escaping (Result<[NodeSubscription], Error>) -> Void
    )

    func startNewSession(
        on subscriptionID: UInt64,
        activeSession: UInt64?,
        sender: TransactionSender,
        node: String,
        completion: @escaping (Result<Bool, Error>) -> Void
    )

    func stop(
        activeSession: UInt64,
        node: String,
        sender: TransactionSender,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}
