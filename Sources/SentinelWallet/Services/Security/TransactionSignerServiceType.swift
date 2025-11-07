//
//  TransactionSignerServiceType.swift
//  
//
//  Created by Lika Vorobeva on 17.05.2023.
//

import Foundation
import HDWallet

// MARK: - TransactionSignerServiceType

public protocol TransactionSignerServiceType {
    func generateMnemonic() -> Result<(String, [String]), Error>
    func restoreAddress(for mnemonic: [String]) -> String?
    func getPublicKey(for mnemonic: [String]) -> PublicKey?
    func generateSignature(for data: Data, with mnemonic: [String]) -> String?
}
