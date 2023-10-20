//
//  Utils.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 02.07.2021.
//

import Foundation
import SwiftProtobuf

final class Utils {
    struct ParsedAuthorization {
        let address: String
        let accountNumber: UInt64
        let sequence: UInt64
    }

    static func parseAuthorization(for account: Google_Protobuf_Any) -> ParsedAuthorization? {
        let urlType = account.typeURL
        if urlType.contains(Cosmos_Auth_V1beta1_BaseAccount.protoMessageName) {
            let auth = try! Cosmos_Auth_V1beta1_BaseAccount(serializedData: account.value)
            return .init(address: auth.address, accountNumber: auth.accountNumber, sequence: auth.sequence)
        }

        if urlType.contains(Cosmos_Vesting_V1beta1_PeriodicVestingAccount.protoMessageName) {
            let auth = try! Cosmos_Vesting_V1beta1_PeriodicVestingAccount(
                serializedData: account.value
            ).baseVestingAccount.baseAccount
            return .init(address: auth.address, accountNumber: auth.accountNumber, sequence: auth.sequence)
        }

        if urlType.contains(Cosmos_Vesting_V1beta1_ContinuousVestingAccount.protoMessageName) {
            let auth = try! Cosmos_Vesting_V1beta1_ContinuousVestingAccount(
                serializedData: account.value
            ).baseVestingAccount.baseAccount
            return .init(address: auth.address, accountNumber: auth.accountNumber, sequence: auth.sequence)
        }

        if urlType.contains(Cosmos_Vesting_V1beta1_DelayedVestingAccount.protoMessageName) {
            let auth = try! Cosmos_Vesting_V1beta1_DelayedVestingAccount(
                serializedData: account.value
            ).baseVestingAccount.baseAccount
            return .init(address: auth.address, accountNumber: auth.accountNumber, sequence: auth.sequence)
        }

        return nil
    }
}
