//
//  BaseData.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation

final class WalletData {
    var exchangeRates = [ExchangeRates]()

    let accountAddress: String

    // For ProtoBuf and gRPC
    var nodeInfo: Tendermint_P2p_DefaultNodeInfo?
    var accountGRPC: Google_Protobuf2_Any?

    var validators = [Cosmos_Staking_V1beta1_Validator]()
    var bondedValidators = [Cosmos_Staking_V1beta1_Validator]()
    var unbondedValidators = [Cosmos_Staking_V1beta1_Validator]()
    var myValidators = [Cosmos_Staking_V1beta1_Validator]()

    var myDelegations = [Cosmos_Staking_V1beta1_DelegationResponse]()
    var unbondingsDelegations = [Cosmos_Staking_V1beta1_UnbondingDelegation]()

    var myBalances = [CoinToken]()
    var myVestings = [CoinToken]()
    var myReward = [Cosmos_Distribution_V1beta1_DelegationDelegatorReward]()

    init(accountAddress: String) {
        self.accountAddress = accountAddress
    }
}
