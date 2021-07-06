//
//  NSDecimalNumberHandler+Ext.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 29.06.2021.
//

import Foundation

extension NSDecimalNumberHandler {
    static let handler0Up = NSDecimalNumberHandler(
        roundingMode: NSDecimalNumber.RoundingMode.up,
        scale: 0,
        raiseOnExactness: false,
        raiseOnOverflow: false,
        raiseOnUnderflow: false,
        raiseOnDivideByZero: true
    )
}
