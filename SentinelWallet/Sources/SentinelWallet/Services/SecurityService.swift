//
//  SecurityService.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 01.07.2021.
//

import Foundation
import SwiftKeychainWrapper
import HDWallet

enum SecurityServiceError: Error {
    case emptyInput
    case invalidInput
}

private struct Constants {
    let key = "password"
}
private let constants = Constants()

final public class SecurityService {
    private let keychain: KeychainWrapper

    public init(keychain: KeychainWrapper = .standard) {
        self.keychain = keychain
    }
    
    func save(mnemonics: [String], for account: String) -> Bool {
        let mnemonicString = mnemonics.joined(separator: " ")
        return keychain.set(
            mnemonicString,
            forKey: account.sha1(),
            withAccessibility: .afterFirstUnlockThisDeviceOnly
        )
    }

    func generateMnemonics() -> String {
        Mnemonic.create(strength: .hight, language: .english)
    }

    func loadMnemonics(for account: String) -> [String]? {
        keychain
            .string(forKey: account.sha1())?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: " ")
    }

    func mnemonicsExists(for account: String) -> Bool {
        keychain.hasValue(forKey: account.sha1())
    }

    func restore(from mnemonics: [String], completion: @escaping ((Result<String, Error>) -> Void)) {
        guard !mnemonics.isEmpty else {
            completion(.failure(SecurityServiceError.emptyInput))
            return
        }

        guard let restoredAddress = restoreAddress(for: mnemonics) else {
            completion(.failure(SecurityServiceError.invalidInput))
            return
        }

        completion(.success(restoredAddress))
    }
}

private extension SecurityService {
    func restoreAddress(for mnemonic: [String]) -> String? {
        let key = PrivateKey(
            seed: Mnemonic.createSeed(mnemonic: mnemonic.joined(separator: " ")),
            coin: .bitcoin
        )
        .derived(at: .hardened(44))
        .derived(at: .hardened(118))
        .derived(at: .hardened(0))
        .derived(at: .notHardened(0))
        .derived(at: .notHardened(UInt32(0)))

        let ripemd160 = RIPEMD160.hash(key.publicKey.data.sha256())

        return try? SegwitAddrCoder.shared.encode2(hrp: "sent", program: ripemd160)
    }
}

