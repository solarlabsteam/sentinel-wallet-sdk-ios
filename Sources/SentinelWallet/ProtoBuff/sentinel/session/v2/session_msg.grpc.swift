//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: sentinel/session/v2/msg.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Sentinel_Session_V2_MsgServiceClient`, then call methods of this protocol to make API calls.
internal protocol Sentinel_Session_V2_MsgServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? { get }

  func msgStart(
    _ request: Sentinel_Session_V2_MsgStartRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Session_V2_MsgStartRequest, Sentinel_Session_V2_MsgStartResponse>

  func msgUpdateDetails(
    _ request: Sentinel_Session_V2_MsgUpdateDetailsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Session_V2_MsgUpdateDetailsRequest, Sentinel_Session_V2_MsgUpdateDetailsResponse>

  func msgEnd(
    _ request: Sentinel_Session_V2_MsgEndRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Session_V2_MsgEndRequest, Sentinel_Session_V2_MsgEndResponse>
}

extension Sentinel_Session_V2_MsgServiceClientProtocol {
  internal var serviceName: String {
    return "sentinel.session.v2.MsgService"
  }

  /// Unary call to MsgStart
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgStart.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgStart(
    _ request: Sentinel_Session_V2_MsgStartRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Session_V2_MsgStartRequest, Sentinel_Session_V2_MsgStartResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgStart.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgStartInterceptors() ?? []
    )
  }

  /// Unary call to MsgUpdateDetails
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgUpdateDetails.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgUpdateDetails(
    _ request: Sentinel_Session_V2_MsgUpdateDetailsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Session_V2_MsgUpdateDetailsRequest, Sentinel_Session_V2_MsgUpdateDetailsResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgUpdateDetails.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUpdateDetailsInterceptors() ?? []
    )
  }

  /// Unary call to MsgEnd
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgEnd.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgEnd(
    _ request: Sentinel_Session_V2_MsgEndRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Session_V2_MsgEndRequest, Sentinel_Session_V2_MsgEndResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgEnd.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgEndInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Sentinel_Session_V2_MsgServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Sentinel_Session_V2_MsgServiceNIOClient")
internal final class Sentinel_Session_V2_MsgServiceClient: Sentinel_Session_V2_MsgServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the sentinel.session.v2.MsgService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Sentinel_Session_V2_MsgServiceNIOClient: Sentinel_Session_V2_MsgServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the sentinel.session.v2.MsgService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Sentinel_Session_V2_MsgServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? { get }

  func makeMsgStartCall(
    _ request: Sentinel_Session_V2_MsgStartRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Session_V2_MsgStartRequest, Sentinel_Session_V2_MsgStartResponse>

  func makeMsgUpdateDetailsCall(
    _ request: Sentinel_Session_V2_MsgUpdateDetailsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Session_V2_MsgUpdateDetailsRequest, Sentinel_Session_V2_MsgUpdateDetailsResponse>

  func makeMsgEndCall(
    _ request: Sentinel_Session_V2_MsgEndRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Session_V2_MsgEndRequest, Sentinel_Session_V2_MsgEndResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Session_V2_MsgServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Sentinel_Session_V2_MsgServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeMsgStartCall(
    _ request: Sentinel_Session_V2_MsgStartRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Session_V2_MsgStartRequest, Sentinel_Session_V2_MsgStartResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgStart.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgStartInterceptors() ?? []
    )
  }

  internal func makeMsgUpdateDetailsCall(
    _ request: Sentinel_Session_V2_MsgUpdateDetailsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Session_V2_MsgUpdateDetailsRequest, Sentinel_Session_V2_MsgUpdateDetailsResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgUpdateDetails.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUpdateDetailsInterceptors() ?? []
    )
  }

  internal func makeMsgEndCall(
    _ request: Sentinel_Session_V2_MsgEndRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Session_V2_MsgEndRequest, Sentinel_Session_V2_MsgEndResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgEnd.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgEndInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Session_V2_MsgServiceAsyncClientProtocol {
  internal func msgStart(
    _ request: Sentinel_Session_V2_MsgStartRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Session_V2_MsgStartResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgStart.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgStartInterceptors() ?? []
    )
  }

  internal func msgUpdateDetails(
    _ request: Sentinel_Session_V2_MsgUpdateDetailsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Session_V2_MsgUpdateDetailsResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgUpdateDetails.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUpdateDetailsInterceptors() ?? []
    )
  }

  internal func msgEnd(
    _ request: Sentinel_Session_V2_MsgEndRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Session_V2_MsgEndResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgEnd.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgEndInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Sentinel_Session_V2_MsgServiceAsyncClient: Sentinel_Session_V2_MsgServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Sentinel_Session_V2_MsgServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'msgStart'.
  func makeMsgStartInterceptors() -> [ClientInterceptor<Sentinel_Session_V2_MsgStartRequest, Sentinel_Session_V2_MsgStartResponse>]

  /// - Returns: Interceptors to use when invoking 'msgUpdateDetails'.
  func makeMsgUpdateDetailsInterceptors() -> [ClientInterceptor<Sentinel_Session_V2_MsgUpdateDetailsRequest, Sentinel_Session_V2_MsgUpdateDetailsResponse>]

  /// - Returns: Interceptors to use when invoking 'msgEnd'.
  func makeMsgEndInterceptors() -> [ClientInterceptor<Sentinel_Session_V2_MsgEndRequest, Sentinel_Session_V2_MsgEndResponse>]
}

internal enum Sentinel_Session_V2_MsgServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "MsgService",
    fullName: "sentinel.session.v2.MsgService",
    methods: [
      Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgStart,
      Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgUpdateDetails,
      Sentinel_Session_V2_MsgServiceClientMetadata.Methods.msgEnd,
    ]
  )

  internal enum Methods {
    internal static let msgStart = GRPCMethodDescriptor(
      name: "MsgStart",
      path: "/sentinel.session.v2.MsgService/MsgStart",
      type: GRPCCallType.unary
    )

    internal static let msgUpdateDetails = GRPCMethodDescriptor(
      name: "MsgUpdateDetails",
      path: "/sentinel.session.v2.MsgService/MsgUpdateDetails",
      type: GRPCCallType.unary
    )

    internal static let msgEnd = GRPCMethodDescriptor(
      name: "MsgEnd",
      path: "/sentinel.session.v2.MsgService/MsgEnd",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Sentinel_Session_V2_MsgServiceProvider: CallHandlerProvider {
  var interceptors: Sentinel_Session_V2_MsgServiceServerInterceptorFactoryProtocol? { get }

  func msgStart(request: Sentinel_Session_V2_MsgStartRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Session_V2_MsgStartResponse>

  func msgUpdateDetails(request: Sentinel_Session_V2_MsgUpdateDetailsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Session_V2_MsgUpdateDetailsResponse>

  func msgEnd(request: Sentinel_Session_V2_MsgEndRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Session_V2_MsgEndResponse>
}

extension Sentinel_Session_V2_MsgServiceProvider {
  internal var serviceName: Substring {
    return Sentinel_Session_V2_MsgServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MsgStart":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Session_V2_MsgStartRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Session_V2_MsgStartResponse>(),
        interceptors: self.interceptors?.makeMsgStartInterceptors() ?? [],
        userFunction: self.msgStart(request:context:)
      )

    case "MsgUpdateDetails":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Session_V2_MsgUpdateDetailsRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Session_V2_MsgUpdateDetailsResponse>(),
        interceptors: self.interceptors?.makeMsgUpdateDetailsInterceptors() ?? [],
        userFunction: self.msgUpdateDetails(request:context:)
      )

    case "MsgEnd":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Session_V2_MsgEndRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Session_V2_MsgEndResponse>(),
        interceptors: self.interceptors?.makeMsgEndInterceptors() ?? [],
        userFunction: self.msgEnd(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Sentinel_Session_V2_MsgServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Sentinel_Session_V2_MsgServiceServerInterceptorFactoryProtocol? { get }

  func msgStart(
    request: Sentinel_Session_V2_MsgStartRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Session_V2_MsgStartResponse

  func msgUpdateDetails(
    request: Sentinel_Session_V2_MsgUpdateDetailsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Session_V2_MsgUpdateDetailsResponse

  func msgEnd(
    request: Sentinel_Session_V2_MsgEndRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Session_V2_MsgEndResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Session_V2_MsgServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Sentinel_Session_V2_MsgServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Sentinel_Session_V2_MsgServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Sentinel_Session_V2_MsgServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MsgStart":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Session_V2_MsgStartRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Session_V2_MsgStartResponse>(),
        interceptors: self.interceptors?.makeMsgStartInterceptors() ?? [],
        wrapping: { try await self.msgStart(request: $0, context: $1) }
      )

    case "MsgUpdateDetails":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Session_V2_MsgUpdateDetailsRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Session_V2_MsgUpdateDetailsResponse>(),
        interceptors: self.interceptors?.makeMsgUpdateDetailsInterceptors() ?? [],
        wrapping: { try await self.msgUpdateDetails(request: $0, context: $1) }
      )

    case "MsgEnd":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Session_V2_MsgEndRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Session_V2_MsgEndResponse>(),
        interceptors: self.interceptors?.makeMsgEndInterceptors() ?? [],
        wrapping: { try await self.msgEnd(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol Sentinel_Session_V2_MsgServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'msgStart'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgStartInterceptors() -> [ServerInterceptor<Sentinel_Session_V2_MsgStartRequest, Sentinel_Session_V2_MsgStartResponse>]

  /// - Returns: Interceptors to use when handling 'msgUpdateDetails'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgUpdateDetailsInterceptors() -> [ServerInterceptor<Sentinel_Session_V2_MsgUpdateDetailsRequest, Sentinel_Session_V2_MsgUpdateDetailsResponse>]

  /// - Returns: Interceptors to use when handling 'msgEnd'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgEndInterceptors() -> [ServerInterceptor<Sentinel_Session_V2_MsgEndRequest, Sentinel_Session_V2_MsgEndResponse>]
}

internal enum Sentinel_Session_V2_MsgServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "MsgService",
    fullName: "sentinel.session.v2.MsgService",
    methods: [
      Sentinel_Session_V2_MsgServiceServerMetadata.Methods.msgStart,
      Sentinel_Session_V2_MsgServiceServerMetadata.Methods.msgUpdateDetails,
      Sentinel_Session_V2_MsgServiceServerMetadata.Methods.msgEnd,
    ]
  )

  internal enum Methods {
    internal static let msgStart = GRPCMethodDescriptor(
      name: "MsgStart",
      path: "/sentinel.session.v2.MsgService/MsgStart",
      type: GRPCCallType.unary
    )

    internal static let msgUpdateDetails = GRPCMethodDescriptor(
      name: "MsgUpdateDetails",
      path: "/sentinel.session.v2.MsgService/MsgUpdateDetails",
      type: GRPCCallType.unary
    )

    internal static let msgEnd = GRPCMethodDescriptor(
      name: "MsgEnd",
      path: "/sentinel.session.v2.MsgService/MsgEnd",
      type: GRPCCallType.unary
    )
  }
}
