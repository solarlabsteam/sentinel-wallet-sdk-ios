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
public struct DVPNNodeInfo: Codable {
    public let address: String

    public let bandwidth: Bandwidth
    public let handshake: Handshake

    public let intervalSetSessions: Int
    public let intervalUpdateSessions: Int
    public let intervalUpdateStatus: Int

    public let location: Location

    public let moniker: String
    public let resultOperator: String

    public let peers: Int
    public let price: String
    public let provider: String

    public let type: Int
    public let version: String

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
public struct Bandwidth: Codable {
    public let download: Int
    public let upload: Int
}

// MARK: - Handshake
public struct Handshake: Codable {
    public let enable: Bool
    public let peers: Int
}

// MARK: - Location
public struct Location: Codable {
    public let city: String
    public let country: String
    let latitude: Double
    let longitude: Double
}
