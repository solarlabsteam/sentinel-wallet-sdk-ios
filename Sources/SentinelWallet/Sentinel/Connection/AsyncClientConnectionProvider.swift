//
//  AsyncClientConnectionProvider.swift
//
//
//  Created by Lika Vorobeva on 19.10.2023.
//

import Foundation
import GRPC
import NIO

protocol AsyncClientConnectionProviderType {
    func channel(for host: String, port: Int) -> ClientConnection
}

final class AsyncClientConnectionProvider {
    private var group: MultiThreadedEventLoopGroup?
    deinit {
        try? group?.syncShutdownGracefully()
    }
}

extension AsyncClientConnectionProvider: AsyncClientConnectionProviderType {
    func channel(for host: String, port: Int) -> ClientConnection {
        let group = group ?? MultiThreadedEventLoopGroup(numberOfThreads: 1)
        return ClientConnection.insecure(group: group).connect(host: host, port: port)
    }
}
