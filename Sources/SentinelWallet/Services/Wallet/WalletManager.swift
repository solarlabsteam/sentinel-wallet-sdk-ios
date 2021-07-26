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

    public func generateWallet(completion: @escaping ((Result<WalletService, Error>) -> Void)) {
        let mnemonics = securityService.generateMnemonics().components(separatedBy: " ")
        restoreWallet(from: mnemonics, completion: completion)
    }

    public func restoreWallet(from mnemonics: [String], completion: @escaping ((Result<WalletService, Error>) -> Void)) {
        securityService.restore(from: mnemonics) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let account):
                log.debug("Loaded account: \(account)")
                self.saveMnemonicsIfNeeded(for: account, mnemonics: mnemonics)
                let walletService = WalletService(for: account, securityService: self.securityService)
                completion(.success(walletService))
            }
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
