//
//  WalletService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 23.06.2021.
//

import Foundation
import HDWallet
import GRPC
import NIO
import SwiftProtobuf

private struct Constants {
    let defaultFeePrice = 10000
    let defaultFee = Fee("100000", [.init(denom: GlobalConstants.denom, amount: "10000")])

    let sendMessageURL = "/cosmos.bank.v1beta1.MsgSend"
}

private let constants = Constants()

public enum WalletServiceError: Error {
    case accountMatchesDestination
    case missingMnemonics
    case missingAuthorization
    case notEnoughTokens

    case mnemonicsDoNotMatch
    case savingError
}

final public class WalletService {
    private let transactionProvider: TransactionProviderType
    private let connectionProvider: ClientConnectionProviderType

    private let validatorsProvider: ValidatorsProviderType
    private let delegationsProvider: DelegationsProviderType
    private let securityService: SecurityServiceType
    
    private var walletData: WalletData
    
    public var currentWalletAddress: String {
        walletData.accountAddress
    }
    
    public var currentWalletChain: String {
        walletData.chainId
    }

    public var fee: Int {
        constants.defaultFeePrice
    }

    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }
    
    public init(
        for accountAddress: String,
        configuration: ClientConnectionConfigurationType,
        securityService: SecurityServiceType
    ) {
        self.walletData = .init(accountAddress: accountAddress)
        self.transactionProvider = TransactionProvider(configuration: configuration)
        self.connectionProvider = ClientConnectionProvider(configuration: configuration)
        self.validatorsProvider = ValidatorsProvider(configuration: configuration)
        self.delegationsProvider = DelegationsProvider(configuration: configuration)
        self.securityService = securityService
    }
}

// MARK: - Public methods: Wallet data

extension WalletService {
    public func manage(address: String) {
        walletData = .init(accountAddress: address)
        
        fetchAuthorization { _ in }
        fetchTendermintNodeInfo { _ in }
    }
    
    public func fetchTendermintNodeInfo(
        callback: @escaping (Result<WalletNodeDTO, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            do {
                let request = Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest()
                let response = try Cosmos_Base_Tendermint_V1beta1_ServiceClient(channel: channel)
                    .getNodeInfo(request, callOptions: self.callOptions)
                    .response
                    .wait()
                    .defaultNodeInfo

                self.walletData.nodeInfo = response
                callback(.success(response.toDTO()))
            } catch {
                callback(.failure(error))
            }
        })
    }

    // Do not forget to update Authorization info before doing any signed requests by calling this method.
    public func fetchAuthorization(
        callback: @escaping (Error?) -> Void
    ) {
        transactionProvider.fetchAuthorization(for: walletData.accountAddress) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(error)
            case .success(let account):
                self?.walletData.accountGRPC = account
                callback(nil)
            }
        }
    }
    
    public func fetchBalance(
        callback: @escaping (Result<[CoinToken], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { [weak self] channel in
            guard let self = self else { return }
            do {
                let req = Cosmos_Bank_V1beta1_QueryAllBalancesRequest.with {
                    $0.address = self.walletData.accountAddress
                }

                let response = try Cosmos_Bank_V1beta1_QueryClient(channel: channel)
                    .allBalances(req, callOptions: callOptions)
                    .response
                    .wait()
                    .balances
                    .map { CoinToken(denom: $0.denom, amount: $0.amount) }

                if response.isEmpty {
                    self.walletData.myBalances = [CoinToken(denom: GlobalConstants.mainDenom, amount: "0")]
                } else {
                    self.walletData.myBalances = response
                }

                callback(.success(response))
            } catch {
                callback(.failure(error))
            }
        })
    }
    
    public func createTransactionSender() -> TransactionSender? {
        guard let mnemonic = securityService.loadMnemonics(for: walletData.accountAddress) else {
            return nil
        }
        
        return .init(
            owner: currentWalletAddress,
            ownerMnemonic: mnemonic,
            chainID: walletData.chainId
        )
    }
}

#warning("TODO: Move to separate service")
// MARK: - Public methods: Validators

extension WalletService {
    public func fetchUnbondedValidators(
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletValidatorDTO], Error>) -> Void
    ) {
        validatorsProvider.fetchValidators(offset: offset, limit: limit, type: .unbonded) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let validators):
                callback(.success(validators.map { $0.toDTO() }))
            }
        }
    }
    
    public func fetchUnbondingValidators(
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletValidatorDTO], Error>) -> Void
    ) {
        validatorsProvider.fetchValidators(offset: offset, limit: limit, type: .undonding) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let validators):
                callback(.success(validators.map { $0.toDTO() }))
            }
        }
    }
    
    public func fetchBondedValidators(
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletValidatorDTO], Error>) -> Void
    ) {
        validatorsProvider.fetchValidators(offset: offset, limit: limit, type: .bonded) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let validators):
                callback(.success(validators.map { $0.toDTO() }))
            }
        }
    }
}

#warning("TODO: Move to separate service")
// MARK: - Public methods: Delegations

extension WalletService {
    public func fetchDelegations(
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletDelegationDTO], Error>) -> Void
    ) {
        delegationsProvider.fetchDelegations(for: walletData.accountAddress, offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let delegations):
                callback(.success(delegations.map { $0.toDTO() }))
            }
        }
    }
    
    public func fetchUnboundingDelegations(
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletUnbondingDelegationDTO], Error>) -> Void
    ) {
        delegationsProvider.fetchUnboundingDelegations(for: walletData.accountAddress, offset: offset, limit: limit) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let delegations):
                callback(.success(delegations.map { $0.toDTO() }))
            }
        }
    }
}

// MARK: - Public methods: Transfer

extension WalletService {
    public func generateSignature(for data: Data) -> String? {
        guard let mnemonic = securityService.loadMnemonics(for: walletData.accountAddress) else {
            log.error(WalletServiceError.missingMnemonics)
            return nil
        }
        
        return generateSignature(for: data, with: mnemonic)
    }
    
    public func generateSignature(for data: Data, with mnemonic: [String]) -> String? {
        let key = Signer.getKey(for: mnemonic)
        return try? ECDSA.compactSign(data: data.sha256(), privateKey: key.raw).base64EncodedString()
    }
    
    public func transfer(
        tokens: CoinToken,
        to account: String,
        memo: String? = nil,
        completion: @escaping (Result<WalletTransactionDTO, Error>) -> Void
    ) {
        guard account != walletData.accountAddress else {
            log.error("Self-sending is not supported")
            return
        }
        
        guard let sender = createTransactionSender() else {
            log.error("Mnemonics are missing")
            completion(.failure(WalletServiceError.missingMnemonics))
            return
        }
        
        let total = constants.defaultFeePrice + (Int(tokens.amount) ?? 0)
        guard total <= self.availableAmount() else {
            log.error("Not enough tokens on wallet")
            completion(.failure(WalletServiceError.notEnoughTokens))
            return
        }

        let sendCoin = Cosmos_Base_V1beta1_Coin.with {
            $0.denom = tokens.denom
            $0.amount = tokens.amount
        }
        let sendMessage = Cosmos_Bank_V1beta1_MsgSend.with {
            $0.fromAddress = self.currentWalletAddress
            $0.toAddress = account
            $0.amount = [sendCoin]
        }
        let anyMessage = Google_Protobuf_Any.with {
            $0.typeURL = constants.sendMessageURL
            $0.value = try! sendMessage.serializedData()
        }
        
        transactionProvider.broadcast(
            sender: sender,
            recipient: account,
            messages: [anyMessage],
            memo: memo,
            gasFactor: 0,
            completion: { result in
                switch result {
                case .failure(let error):
                    log.error(error)
                    completion(.failure(error))
                case .success(let response):
                    log.debug(
                        """
                        Transaction code: \(response.txResponse.code)
                        Transaction hash: \(response.txResponse.txhash)
                        Transaction rawLog: \(response.txResponse.rawLog)
                        Link: https://www.mintscan.io/sentinel/txs/\(response.txResponse.txhash)
                        """
                    )
                    completion(.success(response.toDTO()))
                }
            }
        )
    }
}

// MARK: - Private methods

extension WalletService {
    private func availableAmount() -> Int {
        walletData.myBalances
            .filter { $0.denom == GlobalConstants.denom }
            .map { Int($0.amount) ?? 0 }
            .reduce(0, +)
    }
}
