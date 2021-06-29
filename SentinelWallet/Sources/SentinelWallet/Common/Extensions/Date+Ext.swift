//
//  Date+Ext.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 29.06.2021.
//

import Foundation

public extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
