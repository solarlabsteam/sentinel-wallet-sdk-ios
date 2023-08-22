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
    private var group: MultiThreadedEventLoopGroup?

    public init(configuration: ClientConnectionConfigurationType) {
        self.configuration = configuration
        DispatchQueue.global(qos: .background).async {
            self.group = MultiThreadedEventLoopGroup(numberOfThreads: 10)
        }
    }

    deinit {
        try? group?.syncShutdownGracefully()
    }

    func openConnection(for work: @escaping (ClientConnection) -> Void) {
        let shouldShutdown = group == nil
        let group = group ?? MultiThreadedEventLoopGroup(numberOfThreads: 1)

        let channel = ClientConnection.insecure(group: group).connect(
            host: self.configuration.grpcMirror.host,
            port: self.configuration.grpcMirror.port
        )

        defer {
            try? channel.close().wait()
            if shouldShutdown {
                try? group.syncShutdownGracefully()
            }
        }

        work(channel)
    }
}
