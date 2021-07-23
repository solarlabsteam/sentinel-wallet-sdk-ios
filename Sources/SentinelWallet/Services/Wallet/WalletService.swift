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
}

final public class WalletService {
    private let provider: WalletDataProviderType
    private let dispatchGroup = DispatchGroup()
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

    public func fetch() {
        fetchTendermintNodeInfo()
        fetchAuthorization(for: walletData.accountAddress)
        fetchBondedValidators(with: 0)
        fetchUnbondedValidators(with: 0)
        fetchUnbondingValidators(with: 0)

        fetchBalance(for: walletData.accountAddress)
        fetchDelegations(for: walletData.accountAddress, offset: 0)
        fetchUnboundingDelegations(for: walletData.accountAddress, offset: 0)
        fetchRewards(for: walletData.accountAddress, offset: 0)

        dispatchGroup.notify(queue: .main, work: .init(block: dataLoaded))
    }

    public func add(mnemonics: [String]) {
        guard !securityService.mnemonicsExists(for: walletData.accountAddress) else {
            log.info("Mnemonics're already added")
            return
        }
        securityService.restore(from: mnemonics, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                log.error(error)
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

        dispatchGroup.notify(queue: .main, execute: { [weak self] in
            guard let self = self, let accountGRPC = self.walletData.accountGRPC else {
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
        })
    }

    public func transfer(tokens: CoinToken, to account: String) {
        guard account != walletData.accountAddress else {
            log.error("Self-sending is not supported")
            return
        }

        guard let mnemonics = securityService.loadMnemonics(for: walletData.accountAddress) else {
            log.error("Mnemonics are missing")
            return
        }

        dispatchGroup.notify(queue: .main, execute: { [weak self] in
            guard let self = self else { return }
            guard let accountGRPC = self.walletData.accountGRPC else {
                log.error("Authorization is missing")
                return
            }

            let total = constants.defaultFeeAmount + (Int(tokens.amount) ?? 0)
            guard total <= self.availableAmount() else {
                log.error("Not enough tokens on wallet")
                return
            }

            let request = Signer.generateSignedRequest(
                with: accountGRPC,
                to: account,
                tokens: tokens,
                fee: constants.defaultFee,
                memo: "",
                privateKey: self.securityService.getKey(for: mnemonics),
                chainId: self.walletData.getChainId()
            )

            self.provider.onBroadcastGrpcTx(signedRequest: request, completion: { result in
                switch result {
                case .failure(let error):
                    log.error(error)
                case .success(let response):
                    log.debug(
                        """
                        Transaction code: \(response.txResponse.code)
                        Transaction hash: \(response.txResponse.txhash)
                        Transaction rawLog: \(response.txResponse.rawLog)
                        Link: https://www.mintscan.io/sentinel/txs/\(response.txResponse.txhash)
                        """
                    )
                }
            })
        })
    }
}

private extension WalletService {
    func availableAmount() -> Int {
        walletData.myBalances
            .filter { $0.denom == GlobalConstants.denom }
            .map { Int($0.amount) ?? 0 }
            .reduce(0, +)
    }

    func fetchTendermintNodeInfo() {
        dispatchGroup.enter()

        provider.fetchTendermintNodeInfo { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let info):
                self?.walletData.nodeInfo = info
            }
        }
    }

    func fetchAuthorization(for address: String) {
        dispatchGroup.enter()

        provider.fetchAuthorization(for: address) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let account):
                self?.walletData.accountGRPC = account
            }
        }
    }

    func fetchBondedValidators(with offset: Int) {
        dispatchGroup.enter()

        provider.fetchValidators(offset: offset, type: .bonded) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let validators):
                self?.walletData.bondedValidators.append(contentsOf: validators)
            }
        }
    }

    func fetchUnbondedValidators(with offset: Int) {
        dispatchGroup.enter()

        provider.fetchValidators(offset: offset, type: .unbonded) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let validators):
                self?.walletData.unbondedValidators.append(contentsOf: validators)
            }
        }
    }

    func fetchUnbondingValidators(with offset: Int) {
        dispatchGroup.enter()

        provider.fetchValidators(offset: offset, type: .undonding) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let validators):
                self?.walletData.unbondedValidators.append(contentsOf: validators)
            }
        }
    }

    func fetchBalance(for address: String) {
        dispatchGroup.enter()

        provider.fetchBalance(for: address) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let balance):
                guard !balance.isEmpty else {
                    self?.walletData.myBalances = [CoinToken(denom: GlobalConstants.mainDenom, amount: "0")]
                    return
                }
                self?.walletData.myBalances = balance
            }
        }
    }

    func fetchDelegations(for address: String, offset: Int) {
        dispatchGroup.enter()

        provider.fetchDelegations(for: address, offset: offset) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let delegations):
                self?.walletData.myDelegations.append(contentsOf: delegations)
            }
        }
    }

    func fetchUnboundingDelegations(for address: String, offset: Int) {
        dispatchGroup.enter()

        provider.fetchUnboundingDelegations(for: address, offset: offset) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let delegations):
                self?.walletData.unbondingsDelegations.append(contentsOf: delegations)
            }
        }
    }

    func fetchRewards(for address: String, offset: Int) {
        dispatchGroup.enter()

        provider.fetchRewards(for: address) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let reward):
                self?.walletData.myReward = reward
            }
        }
    }

    func dataLoaded() {
        walletData.validators.append(contentsOf: walletData.bondedValidators)
        walletData.validators.append(contentsOf: walletData.unbondedValidators)

        let myValidators = walletData.validators
            .filter { validator in
                walletData.myDelegations.contains { $0.delegation.validatorAddress == validator.operatorAddress }
                    || walletData.unbondingsDelegations.contains { $0.validatorAddress == validator.operatorAddress }
            }

        walletData.myValidators.append(contentsOf: myValidators)

        log.debug("all validators: \(walletData.validators.count)")
        log.debug("bonded Validators: \(walletData.bondedValidators.count)")
        log.debug("unbondedValidators: \(walletData.unbondedValidators.count)")
        log.debug("my validators: \(walletData.myValidators.count)")
        log.debug("balances count: \(walletData.myBalances.count)")

        walletData.myBalances
            .filter { $0.denom == GlobalConstants.denom }
            .forEach { log.debug("DVPN Balance fetched: \($0.amount)") }

        fetchPriceInfo(for: GlobalConstants.marketPrice)

        guard walletData.nodeInfo != nil else {
            log.error("error_network")
            return
        }
    }

    func fetchPriceInfo(for denoms: String) {
        provider.getPrices(for: denoms) { [weak self] result in
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let result):
                self?.walletData.exchangeRates = result
            }
        }
    }
}
