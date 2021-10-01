//
//  SecurityService.swift
//  DVPNApp
//
//  Created by Lika Vorobyeva on 26.07.2021.
//

import Foundation
import SentinelWallet
import HDWallet
import SwiftKeychainWrapper

public enum SecurityServiceError: Error {
    case emptyInput
    case invalidInput
}

private struct Constants {
    let key = "password"
}
private let constants = Constants()

final public class SecurityService: SecurityServiceType {
    private let keychain: KeychainWrapper

    public init(keychain: KeychainWrapper = .standard) {
        self.keychain = keychain
    }

    public func save(mnemonics: [String], for account: String) -> Bool {
        let mnemonicString = mnemonics.joined(separator: " ")
        return keychain.set(
            mnemonicString,
            forKey: account.sha1(),
            withAccessibility: .afterFirstUnlockThisDeviceOnly
        )
    }

    public func loadMnemonics(for account: String) -> [String]? {
        keychain
            .string(forKey: account.sha1())?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: " ")
    }

    public func mnemonicsExists(for account: String) -> Bool {
        keychain.hasValue(forKey: account.sha1())
    }

    public func restore(from mnemonics: [String]) -> Result<String, Error> {
        guard !mnemonics.isEmpty else {
            return .failure(SecurityServiceError.emptyInput)
        }

        guard let restoredAddress = restoreAddress(for: mnemonics) else {
            return .failure(SecurityServiceError.invalidInput)
        }

        return .success(restoredAddress)
    }
}
