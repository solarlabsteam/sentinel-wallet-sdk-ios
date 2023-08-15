//
//  ConnectionService.swift
//  
//
//  Created by Lika Vorobeva on 04.07.2022.
//

import Foundation
import GRPC
import NIO

private struct Constants {
    let validatorAddr = "sentvaloper1sazxkmhym0zcg9tmzvc4qxesqegs3q4u66tpmf"
}
private let constants = Constants()

final public class ConnectionService {
    private let connectionProvider: ClientConnectionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }

    public init(clientConnectionConfiguration: ClientConnectionConfigurationType) {
        self.connectionProvider = ClientConnectionProvider(configuration: clientConnectionConfiguration)
    }
    
    public func testConnection(completion: @escaping (Result<Bool, Error>) -> Void) {
        connectionProvider.openConnection(for: { [callOptions] channel in
            do {
                let request = Cosmos_Staking_V1beta1_QueryValidatorRequest.with {
                    $0.validatorAddr = constants.validatorAddr
                }

                let response = try Cosmos_Staking_V1beta1_QueryClient(channel: channel)
                    .validator(request, callOptions: callOptions)
                    .response
                    .wait()
                    .hasValidator

                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        })
    }
}
