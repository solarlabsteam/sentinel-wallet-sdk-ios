//
//  CosmostationAPI.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 29.06.2021.
//

import Foundation
import Alamofire

enum CosmostationAPI {
    case price(denoms: String)
}

extension CosmostationAPI {
    var path: String {
        switch self {
        case .price(let denoms):
            return "v1/market/price?id=\(denoms)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .price:
            return .get
        }
    }
}
