//
//  TransactionSignerServiceType.swift
//  
//
//  Created by Lika Vorobeva on 17.05.2023.
//

import Foundation
import HDWallet

public protocol TransactionSignerServiceType {
    func generateMnemonic() -> Result<(String, [String]), Error>
    func restoreAddress(for mnemonic: [String]) -> String?
    func generateSignature(for data: Data, with mnemonic: [String]) -> String?
}

public class TransactionSignerService {
    public init() { }
}

extension TransactionSignerService: TransactionSignerServiceType {
    public func generateMnemonic() -> Result<(String, [String]), Error> {
        let mnemonic = Mnemonic.create(strength: .hight, language: .english)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: " ")
        guard let address = restoreAddress(for: mnemonic) else {
            return .failure(WalletServiceError.savingError)
        }
        return .success((address, mnemonic))
    }

    public func restoreAddress(for mnemonic: [String]) -> String? {
        let key = Signer.getKey(for: mnemonic)
        let ripemd160 = RIPEMD160.hash(key.publicKey.data.sha256())

        return try? SegwitAddrCoder.shared.encode2(hrp: "sent", program: ripemd160)
    }
    
    public func generateSignature(for data: Data, with mnemonic: [String]) -> String? {
        let key = Signer.getKey(for: mnemonic)
        return try? ECDSA.compactSign(data: data.sha256(), privateKey: key.raw).base64EncodedString()
    }
}
