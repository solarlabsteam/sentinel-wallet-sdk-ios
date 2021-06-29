//
//  WalletDataProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation
import GRPC
import NIO
import Alamofire

private struct Constants {
    let baseURLString = "https://api-utility.cosmostation.io/"
    let hostString = "lcd-sentinel-app.cosmostation.io"
}

private let constants = Constants()

enum ValidatorType: String {
    case bonded = "BOND_STATUS_BONDED"
    case undonding = "BOND_STATUS_UNBONDING"
    case unbonded = "BOND_STATUS_UNBONDED"
}

final public class WalletDataProvider {
    var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(8000))
        return callOptions
    }

    func connection(for group: MultiThreadedEventLoopGroup) -> ClientConnection {
        ClientConnection.insecure(group: group).connect(host: constants.hostString, port: 9090)
    }

    func getPrices(for denoms: String, completion: @escaping (Result<[ExchangeRates], Error>) -> Void) {
        let requestType = CosmostationAPI.price(denoms: denoms)
        let url = constants.baseURLString.appending(requestType.path)
        AF.request(url, method: requestType.method)
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: DataResponse<[ExchangeRates], AFError>) in
                switch response.result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let rates):
                    completion(.success(rates))
                }
            }
    }

    func fetchRPCNodeInfo(completion: @escaping (Result<Tendermint_P2p_DefaultNodeInfo, Error>) -> Void) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            do {
                let request = Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest()
                let response = try Cosmos_Base_Tendermint_V1beta1_ServiceClient(channel: channel)
                    .getNodeInfo(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.defaultNodeInfo))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func fetchRPCAuthorization(
        for address: String,
        completion: @escaping (Result<Google_Protobuf2_Any, Error>) -> Void
    ) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            do {
                let request = Cosmos_Auth_V1beta1_QueryAccountRequest.with { $0.address = address }
                let response = try Cosmos_Auth_V1beta1_QueryClient(channel: channel)
                    .account(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.account))
            } catch {
                completion(.failure(error))
            }
        })
    }

    func fetchRPCValidators(
        offset: Int,
        type: ValidatorType,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_Validator], Error>) -> Void
    ) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }

            let page = Cosmos_Base_Query_V1beta1_PageRequest.with { $0.limit = 125 }
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

    func fetchRPCBalance(
        for address: String,
        offset: Int,
        completion: @escaping (Result<[Coin], Error>) -> Void
    ) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }

            let req = Cosmos_Bank_V1beta1_QueryAllBalancesRequest.with {
                $0.address = address
            }
            do {
                let response = try Cosmos_Bank_V1beta1_QueryClient(channel: channel)
                    .allBalances(req, callOptions: self.callOptions)
                    .response
                    .wait()

                completion(.success(response.balances.map { Coin(denom: $0.denom, amount: $0.amount) }))
            } catch {
                completion(.failure(error))
            }
        })
    }


    func fetchRPCDelegations(
        for address: String,
        offset: Int,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_DelegationResponse], Error>) -> Void
    ) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            let request = Cosmos_Staking_V1beta1_QueryDelegatorDelegationsRequest.with { $0.delegatorAddr = address }
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

    func fetchRPCUnboundingDelegations(
        for address: String,
        offset: Int,
        completion: @escaping (Result<[Cosmos_Staking_V1beta1_UnbondingDelegation], Error>) -> Void
    ) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            let request = Cosmos_Staking_V1beta1_QueryDelegatorUnbondingDelegationsRequest
                .with { $0.delegatorAddr = address }
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

    func fetchRPCRewards(
        for address: String,
        offset: Int,
        completion: @escaping (Result<[Cosmos_Distribution_V1beta1_DelegationDelegatorReward], Error>) -> Void
    ) {
        openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            let request = Cosmos_Distribution_V1beta1_QueryDelegationTotalRewardsRequest
                .with { $0.delegatorAddress = address }
            do {
                let response = try Cosmos_Distribution_V1beta1_QueryClient(channel: channel)
                    .delegationTotalRewards(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.rewards))
            } catch {
                completion(.failure(error))
            }
        })
    }
}

private extension WalletDataProvider {
    func openConnection(for work: @escaping (ClientConnection) -> Void) {
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }

            let channel = ClientConnection.insecure(group: group).connect(host: constants.hostString, port: 9090)
            defer { try! channel.close().wait() }

            work(channel)
        }
    }
}
