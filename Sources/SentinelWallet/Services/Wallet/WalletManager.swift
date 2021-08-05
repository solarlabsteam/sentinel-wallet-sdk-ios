//
//  WalletManager.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 01.07.2021.
//

import Foundation

public class WalletManager {
    private let securityService: SecurityServiceType
    public init(securityService: SecurityServiceType) {
        self.securityService = securityService
    }

    public func generateWallet() -> Result<WalletService, Error> {
        let mnemonics = securityService.generateMnemonics().components(separatedBy: " ")
        return restoreWallet(from: mnemonics)
    }

    public func restoreWallet(from mnemonics: [String]) -> Result<WalletService, Error> {
        switch securityService.restore(from: mnemonics) {
        case .failure(let error):
            return .failure(error)

        case .success(let account):
            log.debug("Loaded account: \(account)")
            saveMnemonicsIfNeeded(for: account, mnemonics: mnemonics)
            let walletService = WalletService(for: account, securityService: self.securityService)
            
            return .success(walletService)
        }
    }

    public func wallet(for account: String) -> WalletService {
        .init(for: account, securityService: securityService)
    }
}

private extension WalletManager {
    func saveMnemonicsIfNeeded(for account: String, mnemonics: [String]) {
        guard !securityService.mnemonicsExists(for: account) else { return }
        if !self.securityService.save(mnemonics: mnemonics, for: account) {
            log.error("Failed to save mnemonics info")
        }
    }
}
