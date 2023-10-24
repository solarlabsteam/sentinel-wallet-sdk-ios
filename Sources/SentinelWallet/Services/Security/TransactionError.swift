//
//  TransactionError.swift
//
//
//  Created by Lika Vorobeva on 24.10.2023.
//

import Foundation

public enum TransactionError: Error {
    case accountMatchesDestination
    case missingMnemonics
    case missingAuthorization
    case notEnoughTokens

    case mnemonicsDoNotMatch
    case savingError
}
