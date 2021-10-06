//
//  Session.swift
//  
//
//  Created by Victoria Kostyleva on 04.10.2021.
//

import Foundation

public struct Session {
    public let id: UInt64
    public let durationInSeconds: Int64
    public let node: String

    init(from response: Sentinel_Session_V1_Session) {
        id = response.id
        durationInSeconds = response.duration.seconds
        node = response.node
    }
}
