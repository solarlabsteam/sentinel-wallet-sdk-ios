//
//  NodesProvider.swift
//  SentinelWallet
//
//  Created by Lika Vorobyeva on 14.07.2021.
//

import Foundation
import GRPC
import NIO
import Alamofire

final class NodesProvider {
    private let connectionProvider: ClientConnectionProviderType
    private let transactionProvider: TransactionProviderType
    
    private var callOptions: CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(3000))
        return callOptions
    }

    init(configuration: ClientConnectionConfigurationType) {
        self.connectionProvider = ClientConnectionProvider(configuration: configuration)
        self.transactionProvider = TransactionProvider(configuration: configuration)
    }
}

extension NodesProvider: NodesProviderType {
    public func fetchAvailableNodes(
        offset: UInt64,
        limit: UInt64,
        allowedDenoms: [String] = [GlobalConstants.denom],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let page = Cosmos_Base_Query_V1beta1_PageRequest.with {
                    $0.limit = limit
                    $0.offset = UInt64(offset)
                }
                let request = Sentinel_Node_V1_QueryNodesRequest.with {
                    $0.status = .active
                    $0.pagination = page
                }
                let response = try Sentinel_Node_V1_QueryServiceClient(channel: channel)
                    .queryNodes(request, callOptions: self.callOptions)
                    .response
                    .wait()
                
                let sentinelNodes = response
                    .nodes
                    .filter { node in allowedDenoms.contains(where: node.price.map { $0.denom }.contains)  }
                    .map { SentinelNode(from: $0) }
                
                completion(.success(sentinelNodes))
            } catch {
                completion(.failure(error))
            }
        })
    }
    
    public func queryNodes(
        offset: UInt64 = 0,
        limit: UInt64 = 0,
        allowedDenoms: [String] = [GlobalConstants.denom],
        completion: @escaping (Result<[SentinelNode], Error>) -> Void
    ) {
        fetchAvailableNodes(offset: offset, limit: limit, allowedDenoms: allowedDenoms) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodes):
                completion(.success(nodes))
            }
        }
    }
    
    public func queryInfo(
        for sentinelNode: SentinelNode,
        timeout: TimeInterval = 5,
        completion: @escaping (Result<Node, Error>) -> Void
    ) {
        fetchInfo(for: sentinelNode.remoteURL, timeout: timeout) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let nodeResult):
                guard nodeResult.0.success, let nodeInfo = nodeResult.0.result else {
                    log.error("Failed to get info")
                    return
                }
                
                let node = Node(info: nodeInfo, latency: nodeResult.1)
                completion(.success(node))
            }
        }
    }
    
    public func queryNodeStatus(
        address: String,
        timeout: TimeInterval = 15,
        completion: @escaping (Result<SentinelNode, Error>) -> Void
    ) {
        fetchNode(address: address) { [weak self] result in
            guard let self = self else {
                completion(.failure(NodesProviderError.emptyInfo))
                return
            }
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let sentinelNodeV1Node):
                self.fetchInfo(for: sentinelNodeV1Node.remoteURL, timeout: timeout) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let info):
                        guard info.0.success, let result = info.0.result else {
                            completion(.failure(NodesProviderError.emptyInfo))
                            return
                        }
                        
                        let node = Node(info: result, latency: info.1)
                        completion(.success(.init(from: sentinelNodeV1Node, node: node)))
                    }
                }
            }
        }
    }
}

// MARK: - Private methods

extension NodesProvider {
     private func fetchNode(
        address: String,
        completion: @escaping (Result<Sentinel_Node_V1_Node, Error>) -> Void
    ) {
        connectionProvider.openConnection(for: { channel in
            do {
                let request = Sentinel_Node_V1_QueryNodeRequest.with {
                    $0.address = address
                }
                let response = try Sentinel_Node_V1_QueryServiceClient(channel: channel)
                    .queryNode(request, callOptions: self.callOptions)
                    .response
                    .wait()
                completion(.success(response.node))
            } catch {
                completion(.failure(error))
            }
        })
    }

    private func fetchInfo(
        for nodeURL: String,
        timeout: TimeInterval,
        completion: @escaping (Result<(DVPNNodeResponse, TimeInterval), Error>) -> Void
    ) {
        let requestType = SentinelAPI.details
        let url = nodeURL.appending(requestType.path)

        guard var comps = URLComponents(string: url) else {
            completion(.failure(NodesProviderError.invalidHost(urlString: nodeURL)))
            return
        }

        comps.scheme = "http"

        guard let urlString = comps.string else {
            completion(.failure(NodesProviderError.invalidHost(urlString: nodeURL)))
            return
        }

        AF.request(urlString, method: requestType.method) { $0.timeoutInterval = timeout }
            .validate(statusCode: 200..<300)
            .responseDecodable { (response: DataResponse<DVPNNodeResponse, AFError>) in
                switch response.result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let node):
                    let duration = response.metrics?.taskInterval.duration ?? 0
                    completion(.success((node, duration)))
                }
            }
    }
}
