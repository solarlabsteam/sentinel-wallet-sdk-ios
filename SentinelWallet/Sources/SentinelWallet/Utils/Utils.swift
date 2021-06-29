//
//  Utils.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 25.06.2021.
//

import Foundation
import UIKit

class Utils {
    static func onParseVestingAccount() {
        log.debug("onParseVestingAccount")
        
        guard let account = WalletData.instance.accountGRPC else { return }
        let sBalace = WalletData.instance.myBalances

        if account.typeURL.contains(Cosmos_Vesting_V1beta1_PeriodicVestingAccount.protoMessageName) {
            let vestingAccount = try! Cosmos_Vesting_V1beta1_PeriodicVestingAccount.init(serializedData: account.value)
            sBalace.forEach({ (coin) in
                let denom = coin.denom
                var dpBalance = NSDecimalNumber.zero
                var dpVesting = NSDecimalNumber.zero
                var originalVesting = NSDecimalNumber.zero
                var remainVesting = NSDecimalNumber.zero
                var delegatedVesting = NSDecimalNumber.zero

                dpBalance = NSDecimalNumber.init(string: coin.amount)

                vestingAccount.baseVestingAccount.originalVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        originalVesting = originalVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })

                vestingAccount.baseVestingAccount.delegatedVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        delegatedVesting = delegatedVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })

                remainVesting = Utils.onParsePeriodicRemainVestingsAmountByDenom(vestingAccount, denom)
                dpVesting = remainVesting.subtracting(delegatedVesting)

                dpVesting = dpVesting.compare(NSDecimalNumber.zero).rawValue <= 0 ? NSDecimalNumber.zero : dpVesting

                if (remainVesting.compare(delegatedVesting).rawValue > 0) {
                    dpBalance = dpBalance.subtracting(remainVesting).adding(delegatedVesting);
                }
                if (dpVesting.compare(NSDecimalNumber.zero).rawValue > 0) {
                    let vestingCoin = Coin.init(denom: denom, amount: dpVesting.stringValue)
                    WalletData.instance.myVestings.append(vestingCoin)
                    var replace = -1
                    for i in 0..<WalletData.instance.myBalances.count {
                        if (WalletData.instance.myBalances[i].denom == denom) {
                            replace = i
                        }
                    }
                    if (replace >= 0) {
                        WalletData.instance.myBalances[replace] = Coin.init(denom: denom, amount: dpBalance.stringValue)
                    }
                }
            })

        } else if (account.typeURL.contains(Cosmos_Vesting_V1beta1_ContinuousVestingAccount.protoMessageName)) {
            let vestingAccount = try! Cosmos_Vesting_V1beta1_ContinuousVestingAccount.init(serializedData: account.value)
            sBalace.forEach({ (coin) in
                let denom = coin.denom
                var dpBalance = NSDecimalNumber.zero
                var dpVesting = NSDecimalNumber.zero
                var originalVesting = NSDecimalNumber.zero
                var remainVesting = NSDecimalNumber.zero
                var delegatedVesting = NSDecimalNumber.zero

                dpBalance = NSDecimalNumber.init(string: coin.amount)

                vestingAccount.baseVestingAccount.originalVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        originalVesting = originalVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })

                vestingAccount.baseVestingAccount.delegatedVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        delegatedVesting = delegatedVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })

                let cTime = Date().millisecondsSince1970
                let vestingStart = vestingAccount.startTime * 1000
                let vestingEnd = vestingAccount.baseVestingAccount.endTime * 1000
                if cTime < vestingStart {
                    remainVesting = originalVesting
                } else if cTime > vestingEnd {
                    remainVesting = NSDecimalNumber.zero
                } else {
                    let progress = ((Float)(cTime - vestingStart)) / ((Float)(vestingEnd - vestingStart))
                    remainVesting = originalVesting.multiplying(by: NSDecimalNumber.init(value: 1 - progress), withBehavior: NSDecimalNumberHandler.handler0Up)
                }

                dpVesting = remainVesting.subtracting(delegatedVesting)

                dpVesting = dpVesting.compare(NSDecimalNumber.zero).rawValue <= 0 ? NSDecimalNumber.zero : dpVesting

                if remainVesting.compare(delegatedVesting).rawValue > 0 {
                    dpBalance = dpBalance.subtracting(remainVesting).adding(delegatedVesting);
                }

                if dpVesting.compare(NSDecimalNumber.zero).rawValue > 0 {
                    let vestingCoin = Coin.init(denom: denom, amount: dpVesting.stringValue)
                    WalletData.instance.myVestings.append(vestingCoin)
                    var replace = -1
                    for i in 0..<WalletData.instance.myBalances.count {
                        if WalletData.instance.myBalances[i].denom == denom {
                            replace = i
                        }
                    }
                    if replace >= 0 {
                        WalletData.instance.myBalances[replace] = Coin.init(denom: denom, amount: dpBalance.stringValue)
                    }
                }
            })

        } else if (account.typeURL.contains(Cosmos_Vesting_V1beta1_DelayedVestingAccount.protoMessageName)) {
            let vestingAccount = try! Cosmos_Vesting_V1beta1_DelayedVestingAccount.init(serializedData: account.value)
            sBalace.forEach({ (coin) in
                let denom = coin.denom
                var dpBalance = NSDecimalNumber.zero
                var dpVesting = NSDecimalNumber.zero
                var originalVesting = NSDecimalNumber.zero
                var remainVesting = NSDecimalNumber.zero
                var delegatedVesting = NSDecimalNumber.zero

                dpBalance = NSDecimalNumber.init(string: coin.amount)
                vestingAccount.baseVestingAccount.originalVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        originalVesting = originalVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })

                vestingAccount.baseVestingAccount.delegatedVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        delegatedVesting = delegatedVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })

                let cTime = Date().millisecondsSince1970
                let vestingEnd = vestingAccount.baseVestingAccount.endTime * 1000
                if cTime < vestingEnd {
                    remainVesting = originalVesting
                }

                dpVesting = remainVesting.subtracting(delegatedVesting)
                dpVesting = dpVesting.compare(NSDecimalNumber.zero).rawValue <= 0 ? NSDecimalNumber.zero : dpVesting

                if remainVesting.compare(delegatedVesting).rawValue > 0 {
                    dpBalance = dpBalance.subtracting(remainVesting).adding(delegatedVesting);
                }

                if dpVesting.compare(NSDecimalNumber.zero).rawValue > 0 {
                    let vestingCoin = Coin.init(denom: denom, amount: dpVesting.stringValue)
                    WalletData.instance.myVestings.append(vestingCoin)
                    var replace = -1
                    for i in 0..<WalletData.instance.myBalances.count {
                        if (WalletData.instance.myBalances[i].denom == denom) {
                            replace = i
                        }
                    }
                    if (replace >= 0) {
                        WalletData.instance.myBalances[replace] = Coin.init(denom: denom, amount: dpBalance.stringValue)
                    }
                }
            })
        }
    }

    static func onParsePersisVestingAccount() {
        guard let account = WalletData.instance.accountGRPC else { return }
        let sBalace = WalletData.instance.myBalances

        if (account.typeURL.contains(Cosmos_Vesting_V1beta1_PeriodicVestingAccount.protoMessageName)) {
            let vestingAccount = try! Cosmos_Vesting_V1beta1_PeriodicVestingAccount.init(serializedData: account.value)
            sBalace.forEach({ (coin) in
                let denom = coin.denom
                var bankBalance = NSDecimalNumber.zero
                var dpBalance = NSDecimalNumber.zero
                var dpVesting = NSDecimalNumber.zero
                var remainVesting = NSDecimalNumber.zero

                bankBalance = NSDecimalNumber.init(string: coin.amount)
                remainVesting = Utils.onParsePeriodicRemainVestingsAmountByDenom(vestingAccount, denom)
                dpBalance = bankBalance.compare(remainVesting).rawValue <= 0 ? NSDecimalNumber.zero : bankBalance.subtracting(remainVesting)

                dpVesting = bankBalance.subtracting(dpBalance)

                let vestingCoin = Coin.init(denom: denom, amount: dpVesting.stringValue)
                WalletData.instance.myVestings.append(vestingCoin)
                var replace = -1
                for i in 0..<WalletData.instance.myBalances.count {
                    if (WalletData.instance.myBalances[i].denom == denom) {
                        replace = i
                    }
                }
                if (replace >= 0) {
                    WalletData.instance.myBalances[replace] = Coin.init(denom: denom, amount: dpBalance.stringValue)
                }
            })

        } else if (account.typeURL.contains(Cosmos_Vesting_V1beta1_ContinuousVestingAccount.protoMessageName)) {
            let vestingAccount = try! Cosmos_Vesting_V1beta1_ContinuousVestingAccount.init(serializedData: account.value)
            sBalace.forEach({ (coin) in
                let denom = coin.denom
                var bankBalance = NSDecimalNumber.zero
                var dpBalance = NSDecimalNumber.zero
                var dpVesting = NSDecimalNumber.zero
                var originalVesting = NSDecimalNumber.zero
                var remainVesting = NSDecimalNumber.zero

                bankBalance = NSDecimalNumber.init(string: coin.amount)

                vestingAccount.baseVestingAccount.originalVesting.forEach({ (coin) in
                    if (coin.denom == denom) {
                        originalVesting = originalVesting.adding(NSDecimalNumber.init(string: coin.amount))
                    }
                })
//                log.debug("originalVesting ", denom, "  ", originalVesting)

                let cTime = Date().millisecondsSince1970
                let vestingStart = vestingAccount.startTime * 1000
                let vestingEnd = vestingAccount.baseVestingAccount.endTime * 1000

                if (cTime < vestingStart) {
                    remainVesting = originalVesting
                } else if (cTime > vestingEnd) {
                    remainVesting = NSDecimalNumber.zero
                } else {
                    let progress = ((Float)(cTime - vestingStart)) / ((Float)(vestingEnd - vestingStart))
                    remainVesting = originalVesting.multiplying(by: NSDecimalNumber.init(value: 1 - progress), withBehavior: NSDecimalNumberHandler.handler0Up)
                }

                if (remainVesting.compare(NSDecimalNumber.zero).rawValue > 0) {
                    dpBalance = NSDecimalNumber.zero
                    dpVesting = bankBalance

                } else {
                    dpBalance = bankBalance
                    dpVesting = NSDecimalNumber.zero

                }

                if (dpVesting.compare(NSDecimalNumber.zero).rawValue > 0) {
                    let vestingCoin = Coin.init(denom: denom, amount: dpVesting.stringValue)
                    WalletData.instance.myVestings.append(vestingCoin)
                    var replace = -1
                    for i in 0..<WalletData.instance.myBalances.count {
                        if (WalletData.instance.myBalances[i].denom == denom) {
                            replace = i
                        }
                    }
                    if (replace >= 0) {
                        WalletData.instance.myBalances[replace] = Coin.init(denom: denom, amount: dpBalance.stringValue)
                    }
                }
            })
        }
    }

    static func onParsePeriodicUnLockTime(_ vestingAccount: Cosmos_Vesting_V1beta1_PeriodicVestingAccount, _ position: Int) -> Int64 {
        var result = vestingAccount.startTime
        for i in 0..<(position + 1) {
            result = result + vestingAccount.vestingPeriods[i].length
        }
        return result * 1000
    }

    static func onParsePeriodicRemainVestings(_ vestingAccount: Cosmos_Vesting_V1beta1_PeriodicVestingAccount) -> Array<Cosmos_Vesting_V1beta1_Period> {
        var results = Array<Cosmos_Vesting_V1beta1_Period>()
        let cTime = Date().millisecondsSince1970
        for i in 0..<vestingAccount.vestingPeriods.count {
            let unlockTime = onParsePeriodicUnLockTime(vestingAccount, i)
            if (cTime < unlockTime) {
                let temp = Cosmos_Vesting_V1beta1_Period.with {
                    $0.length = unlockTime
                    $0.amount = vestingAccount.vestingPeriods[i].amount
                }
                results.append(temp)
            }
        }
        return results
    }

    static func onParsePeriodicRemainVestingsByDenom(_ vestingAccount: Cosmos_Vesting_V1beta1_PeriodicVestingAccount, _ denom: String) -> Array<Cosmos_Vesting_V1beta1_Period> {
        var results = Array<Cosmos_Vesting_V1beta1_Period>()
        for vp in onParsePeriodicRemainVestings(vestingAccount) {
            for coin in vp.amount {
                if (coin.denom ==  denom) {
                    results.append(vp)
                }
            }
        }
        return results
    }

    static func onParsePeriodicRemainVestingsAmountByDenom(_ vestingAccount: Cosmos_Vesting_V1beta1_PeriodicVestingAccount, _ denom: String) -> NSDecimalNumber {
        var results = NSDecimalNumber.zero
        let periods = onParsePeriodicRemainVestingsByDenom(vestingAccount, denom)
        for vp in periods {
            for coin in vp.amount {
                if (coin.denom ==  denom) {
                    results = results.adding(NSDecimalNumber.init(string: coin.amount))
                }
            }
        }
        return results
    }
}
