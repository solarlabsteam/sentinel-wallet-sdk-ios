//
//  WalletService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 23.06.2021.
//

import Foundation
import NIO
import GRPC
import Alamofire

final public class WalletService {
    private let accountAddress: String
    private let provider: WalletDataProvider
    private let dispatchGroup = DispatchGroup()

    public init(for accountAddress: String) {
        self.accountAddress = accountAddress
        self.provider = WalletDataProvider()

        Config.setup()
    }

    public func fetch() {
        fetchRPCNodeInfo()
        fetchRPCAuthorization(for: accountAddress)
        fetchRPCBondedValidators(with: 0)
        fetchRPCUnbondedValidators(with: 0)
        fetchRPCUnbondingValidators(with: 0)

        fetchRPCBalance(for: accountAddress, offset: 0)
        fetchRPCDelegations(for: accountAddress, offset: 0)
        fetchRPCUnboundingDelegations(for: accountAddress, offset: 0)
        fetchRPCRewards(for: accountAddress, offset: 0)

        dispatchGroup.notify(queue: .main, work: .init(block: dataLoaded))
    }
}

private extension WalletService {
    func fetchRPCNodeInfo() {
        log.debug("fetchRPCNodeInfo")
        dispatchGroup.enter()

        provider.fetchRPCNodeInfo { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let info):
                WalletData.instance.nodeInfo = info
            }
        }
    }

    func fetchRPCAuthorization(for address: String) {
        log.debug("fetchRPCAuthorization")
        dispatchGroup.enter()

        provider.fetchRPCAuthorization(for: address) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let account):
                WalletData.instance.accountGRPC = account
            }
        }
    }

    func fetchRPCBondedValidators(with offset: Int) {
        log.debug("fetchRPCBondedValidators")
        dispatchGroup.enter()

        provider.fetchRPCValidators(offset: offset, type: .bonded) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let validators):
                WalletData.instance.bondedValidators.append(contentsOf: validators)
            }
        }
    }

    func fetchRPCUnbondedValidators(with offset: Int) {
        log.debug("fetchRPCUnbondedValidators")
        dispatchGroup.enter()

        provider.fetchRPCValidators(offset: offset, type: .unbonded) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let validators):
                WalletData.instance.unbondedValidators.append(contentsOf: validators)
            }
        }
    }

    func fetchRPCUnbondingValidators(with offset: Int) {
        log.debug("fetchRPCUnbondingValidators")
        dispatchGroup.enter()

        provider.fetchRPCValidators(offset: offset, type: .undonding) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let validators):
                WalletData.instance.unbondedValidators.append(contentsOf: validators)
            }
        }
    }

    func fetchRPCBalance(for address: String, offset: Int) {
        log.debug("fetchRPCBalance")
        dispatchGroup.enter()

        provider.fetchRPCBalance(for: address, offset: offset) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let balance):
                guard !balance.isEmpty else {
                    WalletData.instance.myBalances.append(Coin(denom: GlobalConstants.mainDenom, amount: "0"))
                    return
                }
                WalletData.instance.myBalances.append(contentsOf: balance)
            }
        }
    }

    func fetchRPCDelegations(for address: String, offset: Int) {
        log.debug("fetchRPCBalance")
        dispatchGroup.enter()

        provider.fetchRPCDelegations(for: address, offset: offset) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let delegations):
                WalletData.instance.myDelegations.append(contentsOf: delegations)
            }
        }
    }

    func fetchRPCUnboundingDelegations(for address: String, offset: Int) {
        log.debug("fetchRPCUnboundingDelegations")
        dispatchGroup.enter()

        provider.fetchRPCUnboundingDelegations(for: address, offset: offset) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let delegations):
                WalletData.instance.unbondingsDelegations.append(contentsOf: delegations)
            }
        }
    }

    func fetchRPCRewards(for address: String, offset: Int) {
        log.debug("fetchRPCRewards")
        dispatchGroup.enter()

        provider.fetchRPCRewards(for: address, offset: offset) { [weak self] result in
            self?.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let reward):
                WalletData.instance.myReward.append(contentsOf: reward)
            }
        }
    }

    func dataLoaded() {
        let item = WalletData.instance
        item.validators.append(contentsOf: WalletData.instance.bondedValidators)
        item.validators.append(contentsOf: WalletData.instance.unbondedValidators)

        let myValidators = item.validators
            .filter { validator in
                item.myDelegations.contains { $0.delegation.validatorAddress == validator.operatorAddress }
                    || item.unbondingsDelegations.contains { $0.validatorAddress == validator.operatorAddress }
            }

        item.myValidators.append(contentsOf: myValidators)

        log.debug("all validators: \(WalletData.instance.validators.count)")
        log.debug("bonded Validators: \(WalletData.instance.bondedValidators.count)")
        log.debug("unbondedValidators: \(WalletData.instance.unbondedValidators.count)")
        log.debug("my validators: \(WalletData.instance.myValidators.count)")
        log.debug("balances count: \(WalletData.instance.myBalances.count)")

        WalletData.instance.myBalances
            .filter { $0.denom == GlobalConstants.denom }
            .forEach { log.debug("DVPN Balance fetched: \($0.amount)") }

        fetchPriceInfo(for: GlobalConstants.marketPrice)

        guard WalletData.instance.nodeInfo != nil else {
            log.error("error_network")
            return
        }
        if let account = WalletData.instance.accountGRPC, !account.typeURL.contains(Cosmos_Auth_V1beta1_BaseAccount.protoMessageName) {
            Utils.onParseVestingAccount()
        }
    }

    func fetchPriceInfo(for denoms: String) {
        provider.getPrices(for: denoms) { result in
            switch result {
            case .failure(let error):
                log.error(error)
            case .success(let result):
                WalletData.instance.exchangeRates = result
            }
        }
    }
}
