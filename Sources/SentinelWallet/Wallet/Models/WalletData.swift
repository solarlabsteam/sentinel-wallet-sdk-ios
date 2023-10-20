//
//  BaseData.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation
import SwiftProtobuf

final class WalletData {
    var exchangeRates = [ExchangeRates]()

    let accountAddress: String

    // For ProtoBuf and gRPC
    var nodeInfo: Tendermint_P2p_DefaultNodeInfo?
    var accountGRPC: Google_Protobuf_Any?

    var myBalances = [CoinToken]()
    var myVestings = [CoinToken]()
    var myReward = [Cosmos_Distribution_V1beta1_DelegationDelegatorReward]()
    
    var chainId: String {
        nodeInfo?.network ?? ""
    }

    init(accountAddress: String) {
        self.accountAddress = accountAddress
    }
}
