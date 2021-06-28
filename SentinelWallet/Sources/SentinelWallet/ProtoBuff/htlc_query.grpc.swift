//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: htlc/query.proto
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


/// Query provides defines the gRPC querier service
///
/// Usage: instantiate `Irismod_Htlc_QueryClient`, then call methods of this protocol to make API calls.
internal protocol Irismod_Htlc_QueryClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Irismod_Htlc_QueryClientInterceptorFactoryProtocol? { get }

  func hTLC(
    _ request: Irismod_Htlc_QueryHTLCRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Htlc_QueryHTLCRequest, Irismod_Htlc_QueryHTLCResponse>
}

extension Irismod_Htlc_QueryClientProtocol {
  internal var serviceName: String {
    return "irismod.htlc.Query"
  }

  /// HTLC queries the HTLC by the specified hash lock
  ///
  /// - Parameters:
  ///   - request: Request to send to HTLC.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func hTLC(
    _ request: Irismod_Htlc_QueryHTLCRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Htlc_QueryHTLCRequest, Irismod_Htlc_QueryHTLCResponse> {
    return self.makeUnaryCall(
      path: "/irismod.htlc.Query/HTLC",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeHTLCInterceptors() ?? []
    )
  }
}

internal protocol Irismod_Htlc_QueryClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'hTLC'.
  func makeHTLCInterceptors() -> [ClientInterceptor<Irismod_Htlc_QueryHTLCRequest, Irismod_Htlc_QueryHTLCResponse>]
}

internal final class Irismod_Htlc_QueryClient: Irismod_Htlc_QueryClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Irismod_Htlc_QueryClientInterceptorFactoryProtocol?

  /// Creates a client for the irismod.htlc.Query service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Irismod_Htlc_QueryClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Query provides defines the gRPC querier service
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Irismod_Htlc_QueryProvider: CallHandlerProvider {
  var interceptors: Irismod_Htlc_QueryServerInterceptorFactoryProtocol? { get }

  /// HTLC queries the HTLC by the specified hash lock
  func hTLC(request: Irismod_Htlc_QueryHTLCRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Htlc_QueryHTLCResponse>
}

extension Irismod_Htlc_QueryProvider {
  internal var serviceName: Substring { return "irismod.htlc.Query" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "HTLC":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Htlc_QueryHTLCRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Htlc_QueryHTLCResponse>(),
        interceptors: self.interceptors?.makeHTLCInterceptors() ?? [],
        userFunction: self.hTLC(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Irismod_Htlc_QueryServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'hTLC'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeHTLCInterceptors() -> [ServerInterceptor<Irismod_Htlc_QueryHTLCRequest, Irismod_Htlc_QueryHTLCResponse>]
}
