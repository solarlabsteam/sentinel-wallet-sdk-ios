//
//  ClientConnectionProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation
import GRPC
import NIO

private struct Constants {
    let hostString = "lcd-sentinel-app.cosmostation.io"
}
private let constants = Constants()

protocol ClientConnectionProviderType {
    func openConnection(for work: @escaping (ClientConnection) -> Void)
}

final class ClientConnectionProvider: ClientConnectionProviderType {
    func openConnection(for work: @escaping (ClientConnection) -> Void) {
        DispatchQueue.global().async {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }

            let channel = ClientConnection.insecure(group: group).connect(host: constants.hostString, port: 9090)
            defer { try! channel.close().wait() }

            work(channel)
        }
    }
}
