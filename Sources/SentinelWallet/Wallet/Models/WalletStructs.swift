import Foundation

public struct WalletTransactionDTO {
    var height: Int64
    var txhash: String
    var codespace: String
    var code: UInt32
    var data: String
    var info: String
    var gasWanted: Int64
    var gasUsed: Int64
}

extension Cosmos_Tx_V1beta1_BroadcastTxResponse {
    func toDTO() -> WalletTransactionDTO {
        WalletTransactionDTO(
            height: self.txResponse.height,
            txhash: self.txResponse.txhash,
            codespace: self.txResponse.codespace,
            code: self.txResponse.code,
            data: self.txResponse.data,
            info: self.txResponse.info,
            gasWanted: self.txResponse.gasWanted,
            gasUsed: self.txResponse.gasUsed
        )
    }
}

public struct WalletNodeDTO {
    var defaultNodeID: String
    var listenAddr: String
    var network: String
    var version: String
    var moniker: String
    var txIndex: String
    var rpcAddress: String
}

extension Tendermint_P2p_DefaultNodeInfo {
    func toDTO() -> WalletNodeDTO {
        WalletNodeDTO(
            defaultNodeID: self.defaultNodeID,
            listenAddr: self.listenAddr,
            network: self.network,
            version: self.version,
            moniker: self.moniker,
            txIndex: self.other.txIndex,
            rpcAddress: self.other.rpcAddress
        )
    }
}

public enum WalletValidatorStatusDTO {
    case unspecified
    case unbonded
    case unbonding
    case bonded
}

extension Cosmos_Staking_V1beta1_BondStatus {
    func toDTO() -> WalletValidatorStatusDTO {
        switch self {
        case .unspecified: return .unspecified
        case .unbonded: return .unbonded
        case .unbonding: return .unbonding
        case .bonded: return .bonded
        default: return .unspecified
        }
    }
}

public struct WalletValidatorDTO {
    var operatorAddress: String
    var jailed: Bool
    var status: WalletValidatorStatusDTO
    var tokens: String
    var delegatorShares: String
    var moniker: String
    var identity: String
    var website: String
    var securityContact: String
    var details: String
    var unbondingHeight: Int64
    var unbondingTime: Int64
    var commissionRate: String
    var comissionMaxRate: String
    var comissionMaxChangeRate: String
    var minSelfDelegation: String
}

extension Cosmos_Staking_V1beta1_Validator {
    func toDTO() -> WalletValidatorDTO {
        WalletValidatorDTO(
            operatorAddress: self.operatorAddress,
            jailed: self.jailed,
            status: self.status.toDTO(),
            tokens: self.tokens,
            delegatorShares: self.delegatorShares,
            moniker: self.description_p.moniker,
            identity: self.description_p.identity,
            website: self.description_p.website,
            securityContact: self.description_p.securityContact,
            details: self.description_p.details,
            unbondingHeight: self.unbondingHeight,
            unbondingTime: self.unbondingTime.seconds,
            commissionRate: self.commission.commissionRates.rate,
            comissionMaxRate: self.commission.commissionRates.maxRate,
            comissionMaxChangeRate: self.commission.commissionRates.maxChangeRate,
            minSelfDelegation: self.minSelfDelegation
        )
    }
}

public struct WalletDelegationDTO {
    var delegatorAddress: String
    var validatorAddress: String
    var shares: String
    var balance: CoinToken
}

extension Cosmos_Staking_V1beta1_DelegationResponse {
    func toDTO() -> WalletDelegationDTO {
        WalletDelegationDTO(
            delegatorAddress: self.delegation.delegatorAddress,
            validatorAddress: self.delegation.validatorAddress,
            shares: self.delegation.shares,
            balance: CoinToken(denom: self.balance.denom, amount: self.balance.amount)
        )
    }
}

public struct WalletUnbondingDelegationEntryDTO {
    var creationHeight: Int64
    var completionTime: Int64
    var initialBalance: String
    var balance: String
}

extension Cosmos_Staking_V1beta1_UnbondingDelegationEntry {
    func toDTO() -> WalletUnbondingDelegationEntryDTO {
        WalletUnbondingDelegationEntryDTO(
            creationHeight: self.creationHeight,
            completionTime: self.completionTime.seconds,
            initialBalance: self.initialBalance,
            balance: self.balance
        )
    }
}

public struct WalletUnbondingDelegationDTO {
    var delegatorAddress: String
    var validatorAddress: String
    var entries: [WalletUnbondingDelegationEntryDTO]
}

extension Cosmos_Staking_V1beta1_UnbondingDelegation {
    func toDTO() -> WalletUnbondingDelegationDTO {
        WalletUnbondingDelegationDTO(
            delegatorAddress: self.delegatorAddress,
            validatorAddress: self.validatorAddress,
            entries: self.entries.map { $0.toDTO() }
        )
    }
}

public struct WalletDelegatorRewardDTO {
    var validatorAddress: String
    var reward: [CoinToken]
}

extension Cosmos_Distribution_V1beta1_DelegationDelegatorReward {
    func toDTO() -> WalletDelegatorRewardDTO {
        WalletDelegatorRewardDTO(
            validatorAddress: self.validatorAddress,
            reward: self.reward.map {
                CoinToken(denom: $0.denom, amount: $0.amount)
            }
        )
    }
}
