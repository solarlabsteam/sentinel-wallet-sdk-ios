//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: cosmos/base/tendermint/v1beta1/query.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Service defines the gRPC querier service for tendermint queries.
///
/// Usage: instantiate `Cosmos_Base_Tendermint_V1beta1_ServiceClient`, then call methods of this protocol to make API calls.
internal protocol Cosmos_Base_Tendermint_V1beta1_ServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Cosmos_Base_Tendermint_V1beta1_ServiceClientInterceptorFactoryProtocol? { get }

  func getNodeInfo(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest, Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse>

  func getSyncing(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest, Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse>

  func getLatestBlock(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse>

  func getBlockByHeight(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse>

  func getLatestValidatorSet(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse>

  func getValidatorSetByHeight(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse>
}

extension Cosmos_Base_Tendermint_V1beta1_ServiceClientProtocol {
  internal var serviceName: String {
    return "cosmos.base.tendermint.v1beta1.Service"
  }

  /// GetNodeInfo queries the current node info.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetNodeInfo.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getNodeInfo(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest, Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse> {
    return self.makeUnaryCall(
      path: "/cosmos.base.tendermint.v1beta1.Service/GetNodeInfo",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetNodeInfoInterceptors() ?? []
    )
  }

  /// GetSyncing queries node syncing.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetSyncing.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getSyncing(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest, Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse> {
    return self.makeUnaryCall(
      path: "/cosmos.base.tendermint.v1beta1.Service/GetSyncing",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetSyncingInterceptors() ?? []
    )
  }

  /// GetLatestBlock returns the latest block.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetLatestBlock.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getLatestBlock(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse> {
    return self.makeUnaryCall(
      path: "/cosmos.base.tendermint.v1beta1.Service/GetLatestBlock",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetLatestBlockInterceptors() ?? []
    )
  }

  /// GetBlockByHeight queries block for given height.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetBlockByHeight.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getBlockByHeight(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse> {
    return self.makeUnaryCall(
      path: "/cosmos.base.tendermint.v1beta1.Service/GetBlockByHeight",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetBlockByHeightInterceptors() ?? []
    )
  }

  /// GetLatestValidatorSet queries latest validator-set.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetLatestValidatorSet.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getLatestValidatorSet(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse> {
    return self.makeUnaryCall(
      path: "/cosmos.base.tendermint.v1beta1.Service/GetLatestValidatorSet",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetLatestValidatorSetInterceptors() ?? []
    )
  }

  /// GetValidatorSetByHeight queries validator-set at a given height.
  ///
  /// - Parameters:
  ///   - request: Request to send to GetValidatorSetByHeight.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func getValidatorSetByHeight(
    _ request: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse> {
    return self.makeUnaryCall(
      path: "/cosmos.base.tendermint.v1beta1.Service/GetValidatorSetByHeight",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetValidatorSetByHeightInterceptors() ?? []
    )
  }
}

internal protocol Cosmos_Base_Tendermint_V1beta1_ServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'getNodeInfo'.
  func makeGetNodeInfoInterceptors() -> [ClientInterceptor<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest, Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse>]

  /// - Returns: Interceptors to use when invoking 'getSyncing'.
  func makeGetSyncingInterceptors() -> [ClientInterceptor<Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest, Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse>]

  /// - Returns: Interceptors to use when invoking 'getLatestBlock'.
  func makeGetLatestBlockInterceptors() -> [ClientInterceptor<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse>]

  /// - Returns: Interceptors to use when invoking 'getBlockByHeight'.
  func makeGetBlockByHeightInterceptors() -> [ClientInterceptor<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse>]

  /// - Returns: Interceptors to use when invoking 'getLatestValidatorSet'.
  func makeGetLatestValidatorSetInterceptors() -> [ClientInterceptor<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse>]

  /// - Returns: Interceptors to use when invoking 'getValidatorSetByHeight'.
  func makeGetValidatorSetByHeightInterceptors() -> [ClientInterceptor<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse>]
}

internal final class Cosmos_Base_Tendermint_V1beta1_ServiceClient: Cosmos_Base_Tendermint_V1beta1_ServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Cosmos_Base_Tendermint_V1beta1_ServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the cosmos.base.tendermint.v1beta1.Service service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Cosmos_Base_Tendermint_V1beta1_ServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Service defines the gRPC querier service for tendermint queries.
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Cosmos_Base_Tendermint_V1beta1_ServiceProvider: CallHandlerProvider {
  var interceptors: Cosmos_Base_Tendermint_V1beta1_ServiceServerInterceptorFactoryProtocol? { get }

  /// GetNodeInfo queries the current node info.
  func getNodeInfo(request: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse>

  /// GetSyncing queries node syncing.
  func getSyncing(request: Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse>

  /// GetLatestBlock returns the latest block.
  func getLatestBlock(request: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse>

  /// GetBlockByHeight queries block for given height.
  func getBlockByHeight(request: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse>

  /// GetLatestValidatorSet queries latest validator-set.
  func getLatestValidatorSet(request: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse>

  /// GetValidatorSetByHeight queries validator-set at a given height.
  func getValidatorSetByHeight(request: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse>
}

extension Cosmos_Base_Tendermint_V1beta1_ServiceProvider {
  internal var serviceName: Substring { return "cosmos.base.tendermint.v1beta1.Service" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "GetNodeInfo":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest>(),
        responseSerializer: ProtobufSerializer<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse>(),
        interceptors: self.interceptors?.makeGetNodeInfoInterceptors() ?? [],
        userFunction: self.getNodeInfo(request:context:)
      )

    case "GetSyncing":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest>(),
        responseSerializer: ProtobufSerializer<Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse>(),
        interceptors: self.interceptors?.makeGetSyncingInterceptors() ?? [],
        userFunction: self.getSyncing(request:context:)
      )

    case "GetLatestBlock":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest>(),
        responseSerializer: ProtobufSerializer<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse>(),
        interceptors: self.interceptors?.makeGetLatestBlockInterceptors() ?? [],
        userFunction: self.getLatestBlock(request:context:)
      )

    case "GetBlockByHeight":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest>(),
        responseSerializer: ProtobufSerializer<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse>(),
        interceptors: self.interceptors?.makeGetBlockByHeightInterceptors() ?? [],
        userFunction: self.getBlockByHeight(request:context:)
      )

    case "GetLatestValidatorSet":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest>(),
        responseSerializer: ProtobufSerializer<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse>(),
        interceptors: self.interceptors?.makeGetLatestValidatorSetInterceptors() ?? [],
        userFunction: self.getLatestValidatorSet(request:context:)
      )

    case "GetValidatorSetByHeight":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest>(),
        responseSerializer: ProtobufSerializer<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse>(),
        interceptors: self.interceptors?.makeGetValidatorSetByHeightInterceptors() ?? [],
        userFunction: self.getValidatorSetByHeight(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Cosmos_Base_Tendermint_V1beta1_ServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'getNodeInfo'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetNodeInfoInterceptors() -> [ServerInterceptor<Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest, Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse>]

  /// - Returns: Interceptors to use when handling 'getSyncing'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetSyncingInterceptors() -> [ServerInterceptor<Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest, Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse>]

  /// - Returns: Interceptors to use when handling 'getLatestBlock'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetLatestBlockInterceptors() -> [ServerInterceptor<Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse>]

  /// - Returns: Interceptors to use when handling 'getBlockByHeight'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetBlockByHeightInterceptors() -> [ServerInterceptor<Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse>]

  /// - Returns: Interceptors to use when handling 'getLatestValidatorSet'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetLatestValidatorSetInterceptors() -> [ServerInterceptor<Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest, Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse>]

  /// - Returns: Interceptors to use when handling 'getValidatorSetByHeight'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetValidatorSetByHeightInterceptors() -> [ServerInterceptor<Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest, Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse>]
}
