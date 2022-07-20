//
//  WalletService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 23.06.2021.
//

import Foundation
import HDWallet

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
    private let validatorsProvider: ValidatorsProviderType
    private let delegationsProvider: DelegationsProviderType
    private let securityService: SecurityServiceType
    
    private var walletData: WalletData
    
    public var currentWalletAddress: String {
        walletData.accountAddress
    }

    public var fee: Int {
        constants.defaultFeePrice
    }
    
    public init(
        for accountAddress: String,
        configuration: ClientConnectionConfigurationType,
        securityService: SecurityServiceType
    ) {
        self.walletData = .init(accountAddress: accountAddress)
        self.transactionProvider = TransactionProvider(configuration: configuration)
        self.validatorsProvider = ValidatorsProvider(configuration: configuration)
        self.delegationsProvider = DelegationsProvider(configuration: configuration)
        self.securityService = securityService
    }
}

// MARK: - Public methods: Wallet data

extension WalletService {
    public func manage(address: String) {
        walletData = .init(accountAddress: currentWalletAddress)
        
        fetchAuthorization { _ in }
        fetchTendermintNodeInfo { _ in }
    }
    
    public func fetchTendermintNodeInfo(
        callback: @escaping (Result<WalletNodeDTO, Error>) -> Void
    ) {
        transactionProvider.fetchTendermintNodeInfo { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let info):
                self?.walletData.nodeInfo = info
                callback(.success(info.toDTO()))
            }
        }
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
        transactionProvider.fetchBalance(for: walletData.accountAddress) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let balance):
                if balance.isEmpty {
                    self?.walletData.myBalances = [
                        CoinToken(denom: GlobalConstants.mainDenom, amount: "0")
                    ]
                } else {
                    self?.walletData.myBalances = balance
                }
                callback(.success(balance))
            }
        }
    }
    
    public func fetchRewards(
        offset: Int,
        callback: @escaping (Result<[WalletDelegatorRewardDTO], Error>) -> Void
    ) {
        transactionProvider.fetchRewards(for: walletData.accountAddress) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let reward):
                self?.walletData.myReward = reward
                callback(.success(reward.map { $0.toDTO() }))
            }
        }
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
        
        guard let mnemonic = securityService.loadMnemonics(for: walletData.accountAddress) else {
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
        let anyMessage = Google_Protobuf2_Any.with {
            $0.typeURL = constants.sendMessageURL
            $0.value = try! sendMessage.serializedData()
        }
        
        let transactionData = TransactionData(
            owner: walletData.accountAddress,
            ownerMnemonic: mnemonic,
            recipient: account,
            chainID: walletData.getChainId()
        )
        
        transactionProvider.broadcast(
            data: transactionData,
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
