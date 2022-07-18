//
//  ValidatorsProvider.swift
//  
//
//  Created by Lika Vorobeva on 18.07.2022.
//

import Foundation
import GRPC
import NIO

protocol ValidatorsProviderType {
    func fetchValidators(
        offset: Int,
        limit: Int,
        type: ValidatorType,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_Validator], Error>) -> Void
    )
}

final class ValidatorsProvider {
    private let connectionProvider: ClientConnectionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(5000))
        return callOptions
    }
    
    init(
        host: String,
        port: Int
    ) {
        self.connectionProvider = ClientConnectionProvider(host: host, port: port)
    }
}

// MARK: - ValidatorsProviderType

extension ValidatorsProvider: ValidatorsProviderType {
    func fetchValidators(
        offset: Int,
        limit: Int,
        type: ValidatorType,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_Validator], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
            guard let self = self else { return }

            let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                $0.limit = UInt64(limit)
                $0.offset = UInt64(offset)
            }

            let req = Cosmos_Staking_V1beta1_QueryValidatorsRequest.with {
                $0.pagination = page
                $0.status = type.rawValue
            }
            do {
                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel)
                    .validators(req, callOptions:  self.callOptions)
                    .response
                    .wait()

                completion(.success(response.validators))
            } catch {
                completion(.failure(error))
            }
        })
    }
}
