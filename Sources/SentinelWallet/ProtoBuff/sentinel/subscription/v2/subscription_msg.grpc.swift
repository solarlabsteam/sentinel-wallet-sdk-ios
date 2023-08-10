//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: sentinel/subscription/v2/msg.proto
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


/// Usage: instantiate `Sentinel_Subscription_V2_MsgServiceClient`, then call methods of this protocol to make API calls.
internal protocol Sentinel_Subscription_V2_MsgServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Sentinel_Subscription_V2_MsgServiceClientInterceptorFactoryProtocol? { get }

  func msgCancel(
    _ request: Sentinel_Subscription_V2_MsgCancelRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V2_MsgCancelRequest, Sentinel_Subscription_V2_MsgCancelResponse>

  func msgAllocate(
    _ request: Sentinel_Subscription_V2_MsgAllocateRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V2_MsgAllocateRequest, Sentinel_Subscription_V2_MsgAllocateResponse>
}

extension Sentinel_Subscription_V2_MsgServiceClientProtocol {
  internal var serviceName: String {
    return "sentinel.subscription.v2.MsgService"
  }

  /// Unary call to MsgCancel
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgCancel.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgCancel(
    _ request: Sentinel_Subscription_V2_MsgCancelRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V2_MsgCancelRequest, Sentinel_Subscription_V2_MsgCancelResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v2.MsgService/MsgCancel",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgCancelInterceptors() ?? []
    )
  }

  /// Unary call to MsgAllocate
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgAllocate.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgAllocate(
    _ request: Sentinel_Subscription_V2_MsgAllocateRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V2_MsgAllocateRequest, Sentinel_Subscription_V2_MsgAllocateResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v2.MsgService/MsgAllocate",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgAllocateInterceptors() ?? []
    )
  }
}

internal protocol Sentinel_Subscription_V2_MsgServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'msgCancel'.
  func makeMsgCancelInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V2_MsgCancelRequest, Sentinel_Subscription_V2_MsgCancelResponse>]

  /// - Returns: Interceptors to use when invoking 'msgAllocate'.
  func makeMsgAllocateInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V2_MsgAllocateRequest, Sentinel_Subscription_V2_MsgAllocateResponse>]
}

internal final class Sentinel_Subscription_V2_MsgServiceClient: Sentinel_Subscription_V2_MsgServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Subscription_V2_MsgServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the sentinel.subscription.v2.MsgService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Subscription_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Sentinel_Subscription_V2_MsgServiceProvider: CallHandlerProvider {
  var interceptors: Sentinel_Subscription_V2_MsgServiceServerInterceptorFactoryProtocol? { get }

  func msgCancel(request: Sentinel_Subscription_V2_MsgCancelRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V2_MsgCancelResponse>

  func msgAllocate(request: Sentinel_Subscription_V2_MsgAllocateRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V2_MsgAllocateResponse>
}

extension Sentinel_Subscription_V2_MsgServiceProvider {
  internal var serviceName: Substring { return "sentinel.subscription.v2.MsgService" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MsgCancel":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V2_MsgCancelRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V2_MsgCancelResponse>(),
        interceptors: self.interceptors?.makeMsgCancelInterceptors() ?? [],
        userFunction: self.msgCancel(request:context:)
      )

    case "MsgAllocate":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V2_MsgAllocateRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V2_MsgAllocateResponse>(),
        interceptors: self.interceptors?.makeMsgAllocateInterceptors() ?? [],
        userFunction: self.msgAllocate(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Sentinel_Subscription_V2_MsgServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'msgCancel'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgCancelInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V2_MsgCancelRequest, Sentinel_Subscription_V2_MsgCancelResponse>]

  /// - Returns: Interceptors to use when handling 'msgAllocate'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgAllocateInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V2_MsgAllocateRequest, Sentinel_Subscription_V2_MsgAllocateResponse>]
}