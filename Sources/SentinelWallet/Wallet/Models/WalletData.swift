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

    var myBalances = [CoinToken]()
    var myVestings = [CoinToken]()
    var myReward = [Cosmos_Distribution_V1beta1_DelegationDelegatorReward]()

    init(accountAddress: String) {
        self.accountAddress = accountAddress
    }

    // for gRPC func
    func getChainId() -> String {
        nodeInfo?.network ?? ""
    }
}
