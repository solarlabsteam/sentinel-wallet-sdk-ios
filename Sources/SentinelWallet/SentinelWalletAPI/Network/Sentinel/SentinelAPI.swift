//
//  SentinelAPI.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

import Foundation
import Alamofire

enum SentinelAPI {
    case details
}

extension SentinelAPI {
    var path: String {
        switch self {
        case .details:
            return "/status"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .details:
            return .get
        }
    }
}
