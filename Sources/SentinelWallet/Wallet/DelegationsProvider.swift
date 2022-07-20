//
//  DelegationsProvider.swift
//  
//
//  Created by Lika Vorobeva on 18.07.2022.
//

import Foundation
import GRPC
import NIO

protocol DelegationsProviderType {
    func fetchDelegations(
        for address: String,
        offset: Int,
        limit: Int,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_DelegationResponse], Error>) -> Void
    )
    func fetchUnboundingDelegations(
        for address: String,
        offset: Int,
        limit: Int,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_UnbondingDelegation], Error>) -> Void
    )
}

final class DelegationsProvider {
    private let connectionProvider: ClientConnectionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        return callOptions
    }
    
    init(configuration: ClientConnectionConfigurationType) {
        self.connectionProvider = ClientConnectionProvider(configuration: configuration)
    }
}

// MARK: - DelegationsProviderType

extension DelegationsProvider: DelegationsProviderType {
    func fetchDelegations(
        for address: String,
        offset: Int,
        limit: Int,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_DelegationResponse], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                $0.limit = UInt64(limit)
                $0.offset = UInt64(offset)
            }

            let request = Cosmos_Staking_V1beta1_QueryDelegatorDelegationsRequest.with {
                $0.delegatorAddr = address
                $0.pagination = page
            }

            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel)
                    .delegatorDelegations(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.delegationResponses))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func fetchUnboundingDelegations(
        for address: String,
        offset: Int,
        limit: Int,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_UnbondingDelegation], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                $0.limit = UInt64(limit)
                $0.offset = UInt64(offset)
            }

            let request = Cosmos_Staking_V1beta1_QueryDelegatorUnbondingDelegationsRequest.with {
                $0.delegatorAddr = address
                $0.pagination = page
            }

            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel)
                    .delegatorUnbondingDelegations(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.unbondingResponses))
            } catch {
                completion(.failure(error))
            }
        })
    }

}
