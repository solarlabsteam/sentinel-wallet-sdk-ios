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
    let defaultFeeAmount = 10000
    let defaultFee = Fee("100000", [.init(denom: GlobalConstants.denom, amount: "10000")])
}

private let constants = Constants()

enum WalletServiceError: LocalizedError {
    case accountMatchesDestination
    case missingMnemonics
    case missingAuthorization
    case notEnoughTokens
}

final public class WalletService {
    private let provider: WalletDataProviderType
    private let securityService: SecurityService
    private let walletData: WalletData
    
    var accountAddress: String {
        walletData.accountAddress
    }
    
    public init(
        for accountAddress: String,
        securityService: SecurityService = SecurityService()
    ) {
        self.walletData = .init(accountAddress: accountAddress)
        self.provider = WalletDataProvider()
        self.securityService = securityService
    }
    
    private func availableAmount() -> Int {
        walletData.myBalances
            .filter { $0.denom == GlobalConstants.denom }
            .map { Int($0.amount) ?? 0 }
            .reduce(0, +)
    }
    
    public func add(mnemonics: [String], completion: @escaping (Error?) -> Void) {
        guard !securityService.mnemonicsExists(for: walletData.accountAddress) else {
            log.info("Mnemonics're already added")
            completion(nil)
            return
        }
        securityService.restore(from: mnemonics, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let account):
                guard account == self.walletData.accountAddress else {
                    log.error("Mnemonics do not match")
                    return
                }
                guard self.securityService.save(mnemonics: mnemonics, for: account) else {
                    log.error("Failed to save mnemonics info")
                    return
                }
                log.debug("Mnemonics are added for \(account)")
                completion(nil)
            }
        })
    }
    
    public func showMnemonics() -> [String]? {
        securityService.loadMnemonics(for: walletData.accountAddress)
    }
    
    public func generateSignature(for data: Data) -> String? {
        guard let mnemonics = showMnemonics() else {
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
        completion: @escaping ((Result<Cosmos_Tx_V1beta1_BroadcastTxRequest, Error>) -> Void)
    ) {
        guard account != walletData.accountAddress else {
            completion(.failure(WalletServiceError.accountMatchesDestination))
            return
        }
        
        guard let mnemonics = showMnemonics() else {
            completion(.failure(WalletServiceError.missingMnemonics))
            return
        }
        
        guard let accountGRPC = self.walletData.accountGRPC else {
            completion(.failure(WalletServiceError.missingAuthorization))
            return
        }
        
        let request = Signer.generateSignedRequest(
            with: accountGRPC,
            to: account,
            fee: constants.defaultFee,
            for: messages,
            privateKey: self.securityService.getKey(for: mnemonics),
            chainId: self.walletData.getChainId()
        )
        
        completion(.success(request))
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
        
        guard let accountGRPC = self.walletData.accountGRPC else {
            log.error("Authorization is missing")
            completion(.failure(WalletServiceError.missingAuthorization))
            return
        }
        
        let total = constants.defaultFeeAmount + (Int(tokens.amount) ?? 0)
        guard total <= self.availableAmount() else {
            log.error("Not enough tokens on wallet")
            completion(.failure(WalletServiceError.notEnoughTokens))
            return
        }
        
        let request = Signer.generateSignedRequest(
            with: accountGRPC,
            to: account,
            tokens: tokens,
            fee: constants.defaultFee,
            memo: memo ?? "",
            privateKey: self.securityService.getKey(for: mnemonics),
            chainId: self.walletData.getChainId()
        )
        
        provider.onBroadcastGrpcTx(signedRequest: request, completion: { result in
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
    
    public func fetchAuthorization(
        for address: String,
        callback: @escaping (Error?) -> Void
    ) {
        provider.fetchAuthorization(for: address) { [weak self] result in
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
    
    public func fetchBalance(
        for address: String,
        callback: @escaping (Result<[CoinToken], Error>) -> Void
    ) {
        provider.fetchBalance(for: address) { [weak self] result in
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
    
    public func fetchDelegations(
        for address: String,
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletDelegationDTO], Error>) -> Void
    ) {
        provider.fetchDelegations(for: address, offset: offset, limit: limit) { [weak self] result in
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
        for address: String,
        offset: Int,
        limit: Int,
        callback: @escaping (Result<[WalletUnbondingDelegationDTO], Error>) -> Void
    ) {
        provider.fetchUnboundingDelegations(for: address, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
                callback(.failure(error))
            case .success(let delegations):
                callback(.success(delegations.map { $0.toDTO() }))
            }
        }
    }
    
    public func fetchRewards(
        for address: String,
        offset: Int,
        callback: @escaping (Result<[WalletDelegatorRewardDTO], Error>) -> Void
    ) {
        provider.fetchRewards(for: address) { [weak self] result in
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
