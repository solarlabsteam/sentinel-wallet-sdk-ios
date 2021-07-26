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
    func restore(from mnemonics: [String], completion: @escaping ((Result<String, Error>) -> Void))
}

extension SecurityServiceType {
    func generateMnemonics() -> String {
        Mnemonic.create(strength: .hight, language: .english)
    }

    func getKey(for mnemonics: [String]) -> PrivateKey {
        let masterKey = PrivateKey(
            seed: Mnemonic.createSeed(mnemonic: mnemonics.joined(separator: " ")),
            coin: .bitcoin
        )

        return masterKey
            .derived(at: .hardened(44))
            .derived(at: .hardened(118))
            .derived(at: .hardened(0))
            .derived(at: .notHardened(0))
            .derived(at: .notHardened(0))
    }

    public func restoreAddress(for mnemonics: [String]) -> String? {
        let key = getKey(for: mnemonics)
        let ripemd160 = RIPEMD160.hash(key.publicKey.data.sha256())

        return try? SegwitAddrCoder.shared.encode2(hrp: "sent", program: ripemd160)
    }
}
