//
//  TransactionProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation
import GRPC
import NIO
import HDWallet

private struct Constants {
#warning("TODO @lika Calculate gas amount correctly")
    let defaultFeePrice = 10000
    let defaultGas = 100000
    let defaultFee = Fee("100000", [.init(denom: GlobalConstants.denom, amount: "10000")])
    
    let sendMessageURL = "/cosmos.bank.v1beta1.MsgSend"
}

private let constants = Constants()

enum ValidatorType: String {
    case bonded = "BOND_STATUS_BONDED"
    case undonding = "BOND_STATUS_UNBONDING"
    case unbonded = "BOND_STATUS_UNBONDED"
}

public struct TransactionSender {
    let owner: String
    let ownerMnemonic: [String]
    let chainID: String
}

protocol TransactionProviderType {
    func fetchTendermintNodeInfo(completion: @escaping (Result<Tendermint_P2p_DefaultNodeInfo, Error>) -> Void)
    func fetchAuthorization(for address: String, completion: @escaping (Result<Google_Protobuf2_Any, Error>) -> Void)
    func fetchBalance(
        for address: String,
        completion: @escaping (Result<[CoinToken], Error>) -> Void
    )
    func fetchRewards(
        for address: String,
        completion: @escaping (Result<[Cosmos_Distribution_V1beta1_DelegationDelegatorReward], Error>) -> Void
    )
    
    func broadcast(
        sender: TransactionSender,
        recipient: String,
        messages: [Google_Protobuf2_Any],
        gasFactor: Int,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    )
    
    func broadcast(
        sender: TransactionSender,
        recipient: String,
        messages: [Google_Protobuf2_Any],
        memo: String?,
        gasFactor: Int,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    )
}

final class TransactionProvider {
    private let connectionProvider: ClientConnectionProviderType
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(15000))
        return callOptions
    }
    
    init(configuration: ClientConnectionConfigurationType) {
        self.connectionProvider = ClientConnectionProvider(configuration: configuration)
    }
}

// MARK: - TransactionProviderType

extension TransactionProvider: TransactionProviderType {
    func fetchTendermintNodeInfo(completion: @escaping (Result<Tendermint_P2p_DefaultNodeInfo, Error>) -> Void) {
        connectionProvider.openConnection(for: { [weak self] channel in
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

    func fetchAuthorization(
        for address: String,
        completion: @escaping (Result<Google_Protobuf2_Any, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
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

    func fetchBalance(
        for address: String,
        completion: @escaping (Result<[CoinToken], Error>) -> Void
    ) {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        
        return connectionProvider.openConnection(for: { channel in
            let req = Cosmos_Bank_V1beta1_QueryAllBalancesRequest.with {
                $0.address = address
            }

            do {
                let response = try Cosmos_Bank_V1beta1_QueryClient(channel: channel)
                    .allBalances(req, callOptions: callOptions)
                    .response
                    .wait()

                completion(.success(response.balances.map { CoinToken(denom: $0.denom, amount: $0.amount) }))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    func fetchRewards(
        for address: String,
        completion: @escaping (Result<[Cosmos_Distribution_V1beta1_DelegationDelegatorReward], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
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
    
    func broadcast(
        sender: TransactionSender,
        recipient: String,
        messages: [Google_Protobuf2_Any],
        gasFactor: Int,
        completion: @escaping (Result<TransactionResult, Error>) -> Void
    ) {
        broadcast(sender: sender, recipient: recipient, messages: messages, memo: nil, gasFactor: gasFactor) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(TransactionResult(from: response.txResponse)))
            }
        }
    }
    
    func broadcast(
        sender: TransactionSender,
        recipient: String,
        messages: [Google_Protobuf2_Any],
        memo: String?,
        gasFactor: Int = 0,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    ) {
        guard recipient != sender.owner else {
            completion(.failure(WalletServiceError.accountMatchesDestination))
            return
        }
        
        fetchAuthorization(for: sender.owner) { [weak self] result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let accountGRPC):
                guard let self = self else { return }
                
                let gas = constants.defaultGas + (constants.defaultGas / 10 * gasFactor)
                let feePrice = constants.defaultFeePrice + (constants.defaultFeePrice / 10 * gasFactor)
                
                let fee = Fee("\(gas)", [.init(denom: GlobalConstants.denom, amount: "\(feePrice)")])
                
                let request = Signer.generateSignedRequest(
                    with: accountGRPC,
                    to: recipient,
                    fee: fee,
                    for: messages,
                    memo: memo ?? "",
                    mnemonic: sender.ownerMnemonic,
                    chainId: sender.chainID
                )
                
                self.broadcastGrpcTx(signedRequest: request, completion: completion)
            }
        }
    }
}

// MARK: - Private methods

extension TransactionProvider {
    private func broadcastGrpcTx(
        signedRequest: Cosmos_Tx_V1beta1_BroadcastTxRequest,
        completion: @escaping (Result<Cosmos_Tx_V1beta1_BroadcastTxResponse, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let response = try Cosmos_Tx_V1beta1_ServiceClient(channel: channel)
                    .broadcastTx(signedRequest)
                    .response
                    .wait()
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        })
    }
}
