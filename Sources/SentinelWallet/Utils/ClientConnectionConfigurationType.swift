//
//  ClientConnectionConfigurationType.swift
//  
//
//  Created by Lika Vorobeva on 19.07.2022.
//

import Foundation

public struct ClientConnectionConfiguration {
    public let host: String
    public let port: Int
    
    public init(host: String = GlobalConstants.defaultLCDHostString, port: Int = GlobalConstants.defaultLCDPort) {
        self.host = host
        self.port = port
    }
}

public protocol ClientConnectionConfigurationType {
    var grpcMirror: ClientConnectionConfiguration { get }
}
