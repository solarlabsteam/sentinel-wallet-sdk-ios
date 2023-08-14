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
    public var info: DVPNNodeInfo
    public let latency: TimeInterval
    
    public init(info: DVPNNodeInfo, latency: TimeInterval) {
        self.info = info
        self.latency = latency
    }
}

public struct SentinelNode {
    public let address: String
    public let price: [CoinToken]
    public let remoteURL: String
    public var node: Node?
    
    public init(address: String, price: [CoinToken], remoteURL: String, node: Node?) {
        self.address = address
        self.price = price
        self.remoteURL = remoteURL
        self.node = node
    }
}
    
extension SentinelNode {
    init(from sentinelNodeV1Node: Sentinel_Node_V2_Node, node: Node? = nil) {
        self.init(
            address: sentinelNodeV1Node.address,
            price: sentinelNodeV1Node.gigabytePrices.map { .init(from: $0) },
            remoteURL: sentinelNodeV1Node.remoteURL,
            node: node
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

    public var location: Location

    public let moniker: String
    public let resultOperator: String

    public let peers: Int
    public let price: String
    public let provider: String

    public let qos: QOS?

    public let type: Int
    public let version: String
    
    public init(
        address: String,
        bandwidth: Bandwidth,
        handshake: Handshake,
        intervalSetSessions: Int,
        intervalUpdateSessions: Int,
        intervalUpdateStatus: Int,
        location: Location,
        moniker: String,
        resultOperator: String,
        peers: Int,
        price: String,
        provider: String,
        qos: QOS?,
        type: Int,
        version: String
    ) {
        self.address = address
        self.bandwidth = bandwidth
        self.handshake = handshake
        self.intervalSetSessions = intervalSetSessions
        self.intervalUpdateSessions = intervalUpdateSessions
        self.intervalUpdateStatus = intervalUpdateStatus
        self.location = location
        self.moniker = moniker
        self.resultOperator = resultOperator
        self.peers = peers
        self.price = price
        self.provider = provider
        self.qos = qos
        self.type = type
        self.version = version
    }

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
    
    public init(download: Int, upload: Int) {
        self.download = download
        self.upload = upload
    }
}

// MARK: - Handshake
public struct Handshake: Codable {
    public let enable: Bool
    public let peers: Int
    
    public init(enable: Bool, peers: Int) {
        self.enable = enable
        self.peers = peers
    }
}

// MARK: - Location
public struct Location: Codable {
    public let city: String
    public let country: String
    public var continent: String
    public let latitude: Double
    public let longitude: Double
    
    public init(city: String, country: String, continent: String = "", latitude: Double, longitude: Double) {
        self.city = city
        self.country = country
        self.continent = continent
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.country = try container.decode(String.self, forKey: .country)
        self.continent = ""
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}

// MARK: - QOS
public struct QOS: Codable {
    public let maxPeers: Int

    enum CodingKeys: String, CodingKey {
        case maxPeers = "max_peers"
    }
    
    public init(maxPeers: Int) {
        self.maxPeers = maxPeers
    }
}
