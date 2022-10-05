//
//  ClientConnectionProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation
import GRPC
import NIO

protocol ClientConnectionProviderType {
    func openConnection(for work: @escaping (ClientConnection) -> Void)
}

final class ClientConnectionProvider: ClientConnectionProviderType {
    private let configuration: ClientConnectionConfigurationType
    
    public init(configuration: ClientConnectionConfigurationType) {
        self.configuration = configuration
    }
    
    func openConnection(for work: @escaping (ClientConnection) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = ClientConnection.usingTLSBackedByNIOSSL(on: group).connect(
                host: self.configuration.grpcMirror.host,
                port: self.configuration.grpcMirror.port
            )
            defer { try! channel.close().wait() }
            
            work(channel)
        }
    }
}
