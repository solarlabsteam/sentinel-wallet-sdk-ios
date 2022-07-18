//
//  WalletService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 23.06.2021.
//

import Foundation
import Alamofire
import HDWallet

private struct Constants {
    #warning("TODO @lika Calculate gas amount correctly")
    let defaultFeePrice = 10000
    let defaultGas = 100000
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
    private let provider: WalletDataProviderType
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
        host: String = GlobalConstants.defaultLCDHostString,
        port: Int = GlobalConstants.defaultLCDPort,
        securityService: SecurityServiceType
    ) {
        self.walletData = .init(accountAddress: accountAddress)
        self.provider = WalletDataProvider(host: host, port: port)
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
        provider.fetchTendermintNodeInfo { [weak self] result in
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
        provider.fetchAuthorization(for: walletData.accountAddress) { [weak self] result in
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
        provider.fetchBalance(for: walletData.accountAddress) { [weak self] result in
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
        provider.fetchRewards(for: walletData.accountAddress) { [weak self] result in
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
        provider.fetchValidators(offset: offset, limit: limit, type: .unbonded) { result in
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
        provider.fetchValidators(offset: offset, limit: limit, type: .undonding) { result in
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
        provider.fetchValidators(offset: offset, limit: limit, type: .bonded) { result in
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
        provider.fetchDelegations(for: walletData.accountAddress, offset: offset, limit: limit) { result in
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
        provider.fetchUnboundingDelegations(for: walletData.accountAddress, offset: offset, limit: limit) { result in
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
        guard let mnemonics = securityService.loadMnemonics(for: walletData.accountAddress) else {
            log.error(WalletServiceError.missingMnemonics)
            return nil
        }
        
        let key = securityService.getKey(for: mnemonics)
        return try? ECDSA.compactSign(data: data.sha256(), privateKey: key.raw).base64EncodedString()
    }
    
    public func generateSignature(for data: Data, with mnemonics: [String]) -> String? {
        let key = securityService.getKey(for: mnemonics)
        return try? ECDSA.compactSign(data: data.sha256(), privateKey: key.raw).base64EncodedString()
    }
    
    func generateSignedRequest(
        to account: String,
        messages: [Google_Protobuf2_Any],
        gasFactor: Int = 0,
        completion: @escaping ((Result<Cosmos_Tx_V1beta1_BroadcastTxRequest, Error>) -> Void)
    ) {
        guard account != walletData.accountAddress else {
            completion(.failure(WalletServiceError.accountMatchesDestination))
            return
        }
        
        guard let mnemonics = securityService.loadMnemonics(for: walletData.accountAddress) else {
            completion(.failure(WalletServiceError.missingMnemonics))
            return
        }

        fetchAuthorization { [weak self] error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let self = self,  let accountGRPC = self.walletData.accountGRPC else {
                completion(.failure(WalletServiceError.missingAuthorization))
                return
            }
            
            let gas = constants.defaultGas + (constants.defaultGas / 10 * gasFactor)
            let feePrice = constants.defaultFeePrice + (constants.defaultFeePrice / 10 * gasFactor)
            
            let fee = Fee("\(gas)", [.init(denom: GlobalConstants.denom, amount: "\(feePrice)")])
            
            let request = Signer.generateSignedRequest(
                with: accountGRPC,
                to: account,
                fee: fee,
                for: messages,
                memo: "",
                privateKey: self.securityService.getKey(for: mnemonics),
                chainId: self.walletData.getChainId()
            )

            completion(.success(request))
        }
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
        
        guard let mnemonics = securityService.loadMnemonics(for: walletData.accountAddress) else {
            log.error("Mnemonics are missing")
            completion(.failure(WalletServiceError.missingMnemonics))
            return
        }

        fetchAuthorization { [weak self] error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let self = self, let accountGRPC = self.walletData.accountGRPC else {
                log.error("Authorization is missing")
                completion(.failure(WalletServiceError.missingAuthorization))
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

            let request = Signer.generateSignedRequest(
                with: accountGRPC,
                to: account,
                fee: constants.defaultFee,
                for: [anyMessage],
                memo: memo ?? "",
                mode: .async,
                privateKey: self.securityService.getKey(for: mnemonics),
                chainId: self.walletData.getChainId()
            )

            self.provider.onBroadcastGrpcTx(signedRequest: request, completion: { result in
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
            })
        }
    }
    
    public func getPrices(
        for denoms: String,
        callback: @escaping (Result<[ExchangeRates], Error>) -> Void
    ) {
        provider.getPrices(for: denoms) { result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let rates):
                callback(.success(rates))
            }
        }
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
