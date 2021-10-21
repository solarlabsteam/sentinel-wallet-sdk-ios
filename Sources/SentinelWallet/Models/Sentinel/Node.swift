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

public struct Node {
    public let sentinelNode: SentinelNode
    public let info: DVPNNodeInfo
    public let latency: TimeInterval
    
    public init(sentinelNode: SentinelNode, info: DVPNNodeInfo, latency: TimeInterval) {
        self.sentinelNode = sentinelNode
        self.info = info
        self.latency = latency
    }
}

public struct SentinelNode {
    public let address: String
    public let provider: String
    public let price: [CoinToken]
    public let remoteURL: String
    
    public init(address: String, provider: String, price: [CoinToken], remoteURL: String) {
        self.address = address
        self.provider = provider
        self.price = price
        self.remoteURL = remoteURL
    }
}
    
extension SentinelNode {
    init(from node: Sentinel_Node_V1_Node) {
        self.init(
            address: node.address,
            provider: node.provider,
            price: node.price.map { .init(from: $0) },
            remoteURL: node.remoteURL
        )
    }
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

    public let qos: QOS?

    public let type: Int
    public let version: String

    enum CodingKeys: String, CodingKey {
        case address, bandwidth, handshake
        case intervalSetSessions = "interval_set_sessions"
        case intervalUpdateSessions = "interval_update_sessions"
        case intervalUpdateStatus = "interval_update_status"
        case location, moniker
        case resultOperator = "operator"
        case peers, price, provider, type, version, qos
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

// MARK: - QOS
public struct QOS: Codable {
    public let maxPeers: Int

    enum CodingKeys: String, CodingKey {
        case maxPeers = "max_peers"
    }
}
