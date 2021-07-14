//
//  Node.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation

// MARK: - DVPNNodeResponse
struct DVPNNodeResponse: Codable {
    let success: Bool
    let result: DVPNNodeInfo?
}

// MARK: -  DVPNNodeInfo
struct DVPNNodeInfo: Codable {
    let address: String

    let bandwidth: Bandwidth
    let handshake: Handshake

    let intervalSetSessions: Int
    let intervalUpdateSessions: Int
    let intervalUpdateStatus: Int

    let location: Location

    let moniker: String
    let resultOperator: String

    let peers: Int
    let price: String
    let provider: String

    let type: Int
    let version: String

    enum CodingKeys: String, CodingKey {
        case address, bandwidth, handshake
        case intervalSetSessions = "interval_set_sessions"
        case intervalUpdateSessions = "interval_update_sessions"
        case intervalUpdateStatus = "interval_update_status"
        case location, moniker
        case resultOperator = "operator"
        case peers, price, provider, type, version
    }
}

// MARK: - Bandwidth
struct Bandwidth: Codable {
    let download: Int
    let upload: Int
}

// MARK: - Handshake
struct Handshake: Codable {
    let enable: Bool
    let peers: Int
}

// MARK: - Location
struct Location: Codable {
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
}
