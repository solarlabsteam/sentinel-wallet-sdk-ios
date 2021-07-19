//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: osmosis/lockup/tx.proto
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


/// Msg defines the Msg service.
///
/// Usage: instantiate `Osmosis_Lockup_MsgClient`, then call methods of this protocol to make API calls.
internal protocol Osmosis_Lockup_MsgClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Osmosis_Lockup_MsgClientInterceptorFactoryProtocol? { get }

  func lockTokens(
    _ request: Osmosis_Lockup_MsgLockTokens,
    callOptions: CallOptions?
  ) -> UnaryCall<Osmosis_Lockup_MsgLockTokens, Osmosis_Lockup_MsgLockTokensResponse>

  func beginUnlockingAll(
    _ request: Osmosis_Lockup_MsgBeginUnlockingAll,
    callOptions: CallOptions?
  ) -> UnaryCall<Osmosis_Lockup_MsgBeginUnlockingAll, Osmosis_Lockup_MsgBeginUnlockingAllResponse>

  func unlockTokens(
    _ request: Osmosis_Lockup_MsgUnlockTokens,
    callOptions: CallOptions?
  ) -> UnaryCall<Osmosis_Lockup_MsgUnlockTokens, Osmosis_Lockup_MsgUnlockTokensResponse>

  func beginUnlocking(
    _ request: Osmosis_Lockup_MsgBeginUnlocking,
    callOptions: CallOptions?
  ) -> UnaryCall<Osmosis_Lockup_MsgBeginUnlocking, Osmosis_Lockup_MsgBeginUnlockingResponse>

  func unlockPeriodLock(
    _ request: Osmosis_Lockup_MsgUnlockPeriodLock,
    callOptions: CallOptions?
  ) -> UnaryCall<Osmosis_Lockup_MsgUnlockPeriodLock, Osmosis_Lockup_MsgUnlockPeriodLockResponse>
}

extension Osmosis_Lockup_MsgClientProtocol {
  internal var serviceName: String {
    return "osmosis.lockup.Msg"
  }

  /// LockTokens lock tokens
  ///
  /// - Parameters:
  ///   - request: Request to send to LockTokens.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func lockTokens(
    _ request: Osmosis_Lockup_MsgLockTokens,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Osmosis_Lockup_MsgLockTokens, Osmosis_Lockup_MsgLockTokensResponse> {
    return self.makeUnaryCall(
      path: "/osmosis.lockup.Msg/LockTokens",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLockTokensInterceptors() ?? []
    )
  }

  /// BeginUnlockingAll begin unlocking all tokens
  ///
  /// - Parameters:
  ///   - request: Request to send to BeginUnlockingAll.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func beginUnlockingAll(
    _ request: Osmosis_Lockup_MsgBeginUnlockingAll,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Osmosis_Lockup_MsgBeginUnlockingAll, Osmosis_Lockup_MsgBeginUnlockingAllResponse> {
    return self.makeUnaryCall(
      path: "/osmosis.lockup.Msg/BeginUnlockingAll",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeBeginUnlockingAllInterceptors() ?? []
    )
  }

  /// UnlockTokens unlock all unlockable tokens
  ///
  /// - Parameters:
  ///   - request: Request to send to UnlockTokens.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func unlockTokens(
    _ request: Osmosis_Lockup_MsgUnlockTokens,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Osmosis_Lockup_MsgUnlockTokens, Osmosis_Lockup_MsgUnlockTokensResponse> {
    return self.makeUnaryCall(
      path: "/osmosis.lockup.Msg/UnlockTokens",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeUnlockTokensInterceptors() ?? []
    )
  }

  /// MsgBeginUnlocking begins unlocking tokens by lock ID
  ///
  /// - Parameters:
  ///   - request: Request to send to BeginUnlocking.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func beginUnlocking(
    _ request: Osmosis_Lockup_MsgBeginUnlocking,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Osmosis_Lockup_MsgBeginUnlocking, Osmosis_Lockup_MsgBeginUnlockingResponse> {
    return self.makeUnaryCall(
      path: "/osmosis.lockup.Msg/BeginUnlocking",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeBeginUnlockingInterceptors() ?? []
    )
  }

  /// UnlockPeriodLock unlock individual period lock by ID
  ///
  /// - Parameters:
  ///   - request: Request to send to UnlockPeriodLock.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func unlockPeriodLock(
    _ request: Osmosis_Lockup_MsgUnlockPeriodLock,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Osmosis_Lockup_MsgUnlockPeriodLock, Osmosis_Lockup_MsgUnlockPeriodLockResponse> {
    return self.makeUnaryCall(
      path: "/osmosis.lockup.Msg/UnlockPeriodLock",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeUnlockPeriodLockInterceptors() ?? []
    )
  }
}

internal protocol Osmosis_Lockup_MsgClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'lockTokens'.
  func makeLockTokensInterceptors() -> [ClientInterceptor<Osmosis_Lockup_MsgLockTokens, Osmosis_Lockup_MsgLockTokensResponse>]

  /// - Returns: Interceptors to use when invoking 'beginUnlockingAll'.
  func makeBeginUnlockingAllInterceptors() -> [ClientInterceptor<Osmosis_Lockup_MsgBeginUnlockingAll, Osmosis_Lockup_MsgBeginUnlockingAllResponse>]

  /// - Returns: Interceptors to use when invoking 'unlockTokens'.
  func makeUnlockTokensInterceptors() -> [ClientInterceptor<Osmosis_Lockup_MsgUnlockTokens, Osmosis_Lockup_MsgUnlockTokensResponse>]

  /// - Returns: Interceptors to use when invoking 'beginUnlocking'.
  func makeBeginUnlockingInterceptors() -> [ClientInterceptor<Osmosis_Lockup_MsgBeginUnlocking, Osmosis_Lockup_MsgBeginUnlockingResponse>]

  /// - Returns: Interceptors to use when invoking 'unlockPeriodLock'.
  func makeUnlockPeriodLockInterceptors() -> [ClientInterceptor<Osmosis_Lockup_MsgUnlockPeriodLock, Osmosis_Lockup_MsgUnlockPeriodLockResponse>]
}

internal final class Osmosis_Lockup_MsgClient: Osmosis_Lockup_MsgClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Osmosis_Lockup_MsgClientInterceptorFactoryProtocol?

  /// Creates a client for the osmosis.lockup.Msg service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Osmosis_Lockup_MsgClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Msg defines the Msg service.
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Osmosis_Lockup_MsgProvider: CallHandlerProvider {
  var interceptors: Osmosis_Lockup_MsgServerInterceptorFactoryProtocol? { get }

  /// LockTokens lock tokens
  func lockTokens(request: Osmosis_Lockup_MsgLockTokens, context: StatusOnlyCallContext) -> EventLoopFuture<Osmosis_Lockup_MsgLockTokensResponse>

  /// BeginUnlockingAll begin unlocking all tokens
  func beginUnlockingAll(request: Osmosis_Lockup_MsgBeginUnlockingAll, context: StatusOnlyCallContext) -> EventLoopFuture<Osmosis_Lockup_MsgBeginUnlockingAllResponse>

  /// UnlockTokens unlock all unlockable tokens
  func unlockTokens(request: Osmosis_Lockup_MsgUnlockTokens, context: StatusOnlyCallContext) -> EventLoopFuture<Osmosis_Lockup_MsgUnlockTokensResponse>

  /// MsgBeginUnlocking begins unlocking tokens by lock ID
  func beginUnlocking(request: Osmosis_Lockup_MsgBeginUnlocking, context: StatusOnlyCallContext) -> EventLoopFuture<Osmosis_Lockup_MsgBeginUnlockingResponse>

  /// UnlockPeriodLock unlock individual period lock by ID
  func unlockPeriodLock(request: Osmosis_Lockup_MsgUnlockPeriodLock, context: StatusOnlyCallContext) -> EventLoopFuture<Osmosis_Lockup_MsgUnlockPeriodLockResponse>
}

extension Osmosis_Lockup_MsgProvider {
  internal var serviceName: Substring { return "osmosis.lockup.Msg" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "LockTokens":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Osmosis_Lockup_MsgLockTokens>(),
        responseSerializer: ProtobufSerializer<Osmosis_Lockup_MsgLockTokensResponse>(),
        interceptors: self.interceptors?.makeLockTokensInterceptors() ?? [],
        userFunction: self.lockTokens(request:context:)
      )

    case "BeginUnlockingAll":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Osmosis_Lockup_MsgBeginUnlockingAll>(),
        responseSerializer: ProtobufSerializer<Osmosis_Lockup_MsgBeginUnlockingAllResponse>(),
        interceptors: self.interceptors?.makeBeginUnlockingAllInterceptors() ?? [],
        userFunction: self.beginUnlockingAll(request:context:)
      )

    case "UnlockTokens":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Osmosis_Lockup_MsgUnlockTokens>(),
        responseSerializer: ProtobufSerializer<Osmosis_Lockup_MsgUnlockTokensResponse>(),
        interceptors: self.interceptors?.makeUnlockTokensInterceptors() ?? [],
        userFunction: self.unlockTokens(request:context:)
      )

    case "BeginUnlocking":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Osmosis_Lockup_MsgBeginUnlocking>(),
        responseSerializer: ProtobufSerializer<Osmosis_Lockup_MsgBeginUnlockingResponse>(),
        interceptors: self.interceptors?.makeBeginUnlockingInterceptors() ?? [],
        userFunction: self.beginUnlocking(request:context:)
      )

    case "UnlockPeriodLock":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Osmosis_Lockup_MsgUnlockPeriodLock>(),
        responseSerializer: ProtobufSerializer<Osmosis_Lockup_MsgUnlockPeriodLockResponse>(),
        interceptors: self.interceptors?.makeUnlockPeriodLockInterceptors() ?? [],
        userFunction: self.unlockPeriodLock(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Osmosis_Lockup_MsgServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'lockTokens'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeLockTokensInterceptors() -> [ServerInterceptor<Osmosis_Lockup_MsgLockTokens, Osmosis_Lockup_MsgLockTokensResponse>]

  /// - Returns: Interceptors to use when handling 'beginUnlockingAll'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeBeginUnlockingAllInterceptors() -> [ServerInterceptor<Osmosis_Lockup_MsgBeginUnlockingAll, Osmosis_Lockup_MsgBeginUnlockingAllResponse>]

  /// - Returns: Interceptors to use when handling 'unlockTokens'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeUnlockTokensInterceptors() -> [ServerInterceptor<Osmosis_Lockup_MsgUnlockTokens, Osmosis_Lockup_MsgUnlockTokensResponse>]

  /// - Returns: Interceptors to use when handling 'beginUnlocking'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeBeginUnlockingInterceptors() -> [ServerInterceptor<Osmosis_Lockup_MsgBeginUnlocking, Osmosis_Lockup_MsgBeginUnlockingResponse>]

  /// - Returns: Interceptors to use when handling 'unlockPeriodLock'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeUnlockPeriodLockInterceptors() -> [ServerInterceptor<Osmosis_Lockup_MsgUnlockPeriodLock, Osmosis_Lockup_MsgUnlockPeriodLockResponse>]
}
