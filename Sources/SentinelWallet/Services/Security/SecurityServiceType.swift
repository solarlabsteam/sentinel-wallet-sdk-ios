//
//  SecurityServiceType.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 01.07.2021.
//

import Foundation
import HDWallet

public protocol SecurityServiceType {
    func save(mnemonics: [String], for account: String) -> Bool
    func loadMnemonics(for account: String) -> [String]?
    func mnemonicsExists(for account: String) -> Bool
    func restore(from mnemonics: [String]) -> Result<String, Error>
}

extension SecurityServiceType {
    public func generateMnemonics() -> String {
        Mnemonic.create(strength: .hight, language: .english)
    }

    public func restoreAddress(for mnemonics: [String]) -> String? {
        let key = getKey(for: mnemonics)
        let ripemd160 = RIPEMD160.hash(key.publicKey.data.sha256())

        return try? SegwitAddrCoder.shared.encode2(hrp: "sent", program: ripemd160)
    }
}
