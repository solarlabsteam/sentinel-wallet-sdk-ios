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
    private let hostString: String
    private let port: Int
    
    init(host: String, port: Int) {
        self.hostString = host
        self.port = port
    }
    
    func openConnection(for work: @escaping (ClientConnection) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
            defer { try! group.syncShutdownGracefully() }
            
            let channel = ClientConnection.insecure(group: group).connect(host: self.hostString, port: self.port)
            defer { try! channel.close().wait() }
            
            work(channel)
        }
    }
}
