//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: sentinel/plan/v2/msg.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Sentinel_Plan_V2_MsgServiceClient`, then call methods of this protocol to make API calls.
internal protocol Sentinel_Plan_V2_MsgServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? { get }

  func msgCreate(
    _ request: Sentinel_Plan_V2_MsgCreateRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Plan_V2_MsgCreateRequest, Sentinel_Plan_V2_MsgCreateResponse>

  func msgUpdateStatus(
    _ request: Sentinel_Plan_V2_MsgUpdateStatusRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Plan_V2_MsgUpdateStatusRequest, Sentinel_Plan_V2_MsgUpdateStatusResponse>

  func msgLinkNode(
    _ request: Sentinel_Plan_V2_MsgLinkNodeRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Plan_V2_MsgLinkNodeRequest, Sentinel_Plan_V2_MsgLinkNodeResponse>

  func msgUnlinkNode(
    _ request: Sentinel_Plan_V2_MsgUnlinkNodeRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Plan_V2_MsgUnlinkNodeRequest, Sentinel_Plan_V2_MsgUnlinkNodeResponse>

  func msgSubscribe(
    _ request: Sentinel_Plan_V2_MsgSubscribeRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Plan_V2_MsgSubscribeRequest, Sentinel_Plan_V2_MsgSubscribeResponse>
}

extension Sentinel_Plan_V2_MsgServiceClientProtocol {
  internal var serviceName: String {
    return "sentinel.plan.v2.MsgService"
  }

  /// Unary call to MsgCreate
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgCreate.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgCreate(
    _ request: Sentinel_Plan_V2_MsgCreateRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Plan_V2_MsgCreateRequest, Sentinel_Plan_V2_MsgCreateResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgCreate.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgCreateInterceptors() ?? []
    )
  }

  /// Unary call to MsgUpdateStatus
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgUpdateStatus.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgUpdateStatus(
    _ request: Sentinel_Plan_V2_MsgUpdateStatusRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Plan_V2_MsgUpdateStatusRequest, Sentinel_Plan_V2_MsgUpdateStatusResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUpdateStatus.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUpdateStatusInterceptors() ?? []
    )
  }

  /// Unary call to MsgLinkNode
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgLinkNode.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgLinkNode(
    _ request: Sentinel_Plan_V2_MsgLinkNodeRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Plan_V2_MsgLinkNodeRequest, Sentinel_Plan_V2_MsgLinkNodeResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgLinkNode.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgLinkNodeInterceptors() ?? []
    )
  }

  /// Unary call to MsgUnlinkNode
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgUnlinkNode.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgUnlinkNode(
    _ request: Sentinel_Plan_V2_MsgUnlinkNodeRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Plan_V2_MsgUnlinkNodeRequest, Sentinel_Plan_V2_MsgUnlinkNodeResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUnlinkNode.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUnlinkNodeInterceptors() ?? []
    )
  }

  /// Unary call to MsgSubscribe
  ///
  /// - Parameters:
  ///   - request: Request to send to MsgSubscribe.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func msgSubscribe(
    _ request: Sentinel_Plan_V2_MsgSubscribeRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Plan_V2_MsgSubscribeRequest, Sentinel_Plan_V2_MsgSubscribeResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgSubscribe.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgSubscribeInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Sentinel_Plan_V2_MsgServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Sentinel_Plan_V2_MsgServiceNIOClient")
internal final class Sentinel_Plan_V2_MsgServiceClient: Sentinel_Plan_V2_MsgServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the sentinel.plan.v2.MsgService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Sentinel_Plan_V2_MsgServiceNIOClient: Sentinel_Plan_V2_MsgServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the sentinel.plan.v2.MsgService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Sentinel_Plan_V2_MsgServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? { get }

  func makeMsgCreateCall(
    _ request: Sentinel_Plan_V2_MsgCreateRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgCreateRequest, Sentinel_Plan_V2_MsgCreateResponse>

  func makeMsgUpdateStatusCall(
    _ request: Sentinel_Plan_V2_MsgUpdateStatusRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgUpdateStatusRequest, Sentinel_Plan_V2_MsgUpdateStatusResponse>

  func makeMsgLinkNodeCall(
    _ request: Sentinel_Plan_V2_MsgLinkNodeRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgLinkNodeRequest, Sentinel_Plan_V2_MsgLinkNodeResponse>

  func makeMsgUnlinkNodeCall(
    _ request: Sentinel_Plan_V2_MsgUnlinkNodeRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgUnlinkNodeRequest, Sentinel_Plan_V2_MsgUnlinkNodeResponse>

  func makeMsgSubscribeCall(
    _ request: Sentinel_Plan_V2_MsgSubscribeRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgSubscribeRequest, Sentinel_Plan_V2_MsgSubscribeResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Plan_V2_MsgServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Sentinel_Plan_V2_MsgServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeMsgCreateCall(
    _ request: Sentinel_Plan_V2_MsgCreateRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgCreateRequest, Sentinel_Plan_V2_MsgCreateResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgCreate.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgCreateInterceptors() ?? []
    )
  }

  internal func makeMsgUpdateStatusCall(
    _ request: Sentinel_Plan_V2_MsgUpdateStatusRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgUpdateStatusRequest, Sentinel_Plan_V2_MsgUpdateStatusResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUpdateStatus.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUpdateStatusInterceptors() ?? []
    )
  }

  internal func makeMsgLinkNodeCall(
    _ request: Sentinel_Plan_V2_MsgLinkNodeRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgLinkNodeRequest, Sentinel_Plan_V2_MsgLinkNodeResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgLinkNode.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgLinkNodeInterceptors() ?? []
    )
  }

  internal func makeMsgUnlinkNodeCall(
    _ request: Sentinel_Plan_V2_MsgUnlinkNodeRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgUnlinkNodeRequest, Sentinel_Plan_V2_MsgUnlinkNodeResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUnlinkNode.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUnlinkNodeInterceptors() ?? []
    )
  }

  internal func makeMsgSubscribeCall(
    _ request: Sentinel_Plan_V2_MsgSubscribeRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Plan_V2_MsgSubscribeRequest, Sentinel_Plan_V2_MsgSubscribeResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgSubscribe.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgSubscribeInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Plan_V2_MsgServiceAsyncClientProtocol {
  internal func msgCreate(
    _ request: Sentinel_Plan_V2_MsgCreateRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Plan_V2_MsgCreateResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgCreate.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgCreateInterceptors() ?? []
    )
  }

  internal func msgUpdateStatus(
    _ request: Sentinel_Plan_V2_MsgUpdateStatusRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Plan_V2_MsgUpdateStatusResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUpdateStatus.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUpdateStatusInterceptors() ?? []
    )
  }

  internal func msgLinkNode(
    _ request: Sentinel_Plan_V2_MsgLinkNodeRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Plan_V2_MsgLinkNodeResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgLinkNode.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgLinkNodeInterceptors() ?? []
    )
  }

  internal func msgUnlinkNode(
    _ request: Sentinel_Plan_V2_MsgUnlinkNodeRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Plan_V2_MsgUnlinkNodeResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUnlinkNode.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgUnlinkNodeInterceptors() ?? []
    )
  }

  internal func msgSubscribe(
    _ request: Sentinel_Plan_V2_MsgSubscribeRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Plan_V2_MsgSubscribeResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgSubscribe.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeMsgSubscribeInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Sentinel_Plan_V2_MsgServiceAsyncClient: Sentinel_Plan_V2_MsgServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Sentinel_Plan_V2_MsgServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'msgCreate'.
  func makeMsgCreateInterceptors() -> [ClientInterceptor<Sentinel_Plan_V2_MsgCreateRequest, Sentinel_Plan_V2_MsgCreateResponse>]

  /// - Returns: Interceptors to use when invoking 'msgUpdateStatus'.
  func makeMsgUpdateStatusInterceptors() -> [ClientInterceptor<Sentinel_Plan_V2_MsgUpdateStatusRequest, Sentinel_Plan_V2_MsgUpdateStatusResponse>]

  /// - Returns: Interceptors to use when invoking 'msgLinkNode'.
  func makeMsgLinkNodeInterceptors() -> [ClientInterceptor<Sentinel_Plan_V2_MsgLinkNodeRequest, Sentinel_Plan_V2_MsgLinkNodeResponse>]

  /// - Returns: Interceptors to use when invoking 'msgUnlinkNode'.
  func makeMsgUnlinkNodeInterceptors() -> [ClientInterceptor<Sentinel_Plan_V2_MsgUnlinkNodeRequest, Sentinel_Plan_V2_MsgUnlinkNodeResponse>]

  /// - Returns: Interceptors to use when invoking 'msgSubscribe'.
  func makeMsgSubscribeInterceptors() -> [ClientInterceptor<Sentinel_Plan_V2_MsgSubscribeRequest, Sentinel_Plan_V2_MsgSubscribeResponse>]
}

internal enum Sentinel_Plan_V2_MsgServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "MsgService",
    fullName: "sentinel.plan.v2.MsgService",
    methods: [
      Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgCreate,
      Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUpdateStatus,
      Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgLinkNode,
      Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgUnlinkNode,
      Sentinel_Plan_V2_MsgServiceClientMetadata.Methods.msgSubscribe,
    ]
  )

  internal enum Methods {
    internal static let msgCreate = GRPCMethodDescriptor(
      name: "MsgCreate",
      path: "/sentinel.plan.v2.MsgService/MsgCreate",
      type: GRPCCallType.unary
    )

    internal static let msgUpdateStatus = GRPCMethodDescriptor(
      name: "MsgUpdateStatus",
      path: "/sentinel.plan.v2.MsgService/MsgUpdateStatus",
      type: GRPCCallType.unary
    )

    internal static let msgLinkNode = GRPCMethodDescriptor(
      name: "MsgLinkNode",
      path: "/sentinel.plan.v2.MsgService/MsgLinkNode",
      type: GRPCCallType.unary
    )

    internal static let msgUnlinkNode = GRPCMethodDescriptor(
      name: "MsgUnlinkNode",
      path: "/sentinel.plan.v2.MsgService/MsgUnlinkNode",
      type: GRPCCallType.unary
    )

    internal static let msgSubscribe = GRPCMethodDescriptor(
      name: "MsgSubscribe",
      path: "/sentinel.plan.v2.MsgService/MsgSubscribe",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Sentinel_Plan_V2_MsgServiceProvider: CallHandlerProvider {
  var interceptors: Sentinel_Plan_V2_MsgServiceServerInterceptorFactoryProtocol? { get }

  func msgCreate(request: Sentinel_Plan_V2_MsgCreateRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Plan_V2_MsgCreateResponse>

  func msgUpdateStatus(request: Sentinel_Plan_V2_MsgUpdateStatusRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Plan_V2_MsgUpdateStatusResponse>

  func msgLinkNode(request: Sentinel_Plan_V2_MsgLinkNodeRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Plan_V2_MsgLinkNodeResponse>

  func msgUnlinkNode(request: Sentinel_Plan_V2_MsgUnlinkNodeRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Plan_V2_MsgUnlinkNodeResponse>

  func msgSubscribe(request: Sentinel_Plan_V2_MsgSubscribeRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Plan_V2_MsgSubscribeResponse>
}

extension Sentinel_Plan_V2_MsgServiceProvider {
  internal var serviceName: Substring {
    return Sentinel_Plan_V2_MsgServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MsgCreate":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgCreateRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgCreateResponse>(),
        interceptors: self.interceptors?.makeMsgCreateInterceptors() ?? [],
        userFunction: self.msgCreate(request:context:)
      )

    case "MsgUpdateStatus":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgUpdateStatusRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgUpdateStatusResponse>(),
        interceptors: self.interceptors?.makeMsgUpdateStatusInterceptors() ?? [],
        userFunction: self.msgUpdateStatus(request:context:)
      )

    case "MsgLinkNode":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgLinkNodeRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgLinkNodeResponse>(),
        interceptors: self.interceptors?.makeMsgLinkNodeInterceptors() ?? [],
        userFunction: self.msgLinkNode(request:context:)
      )

    case "MsgUnlinkNode":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgUnlinkNodeRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgUnlinkNodeResponse>(),
        interceptors: self.interceptors?.makeMsgUnlinkNodeInterceptors() ?? [],
        userFunction: self.msgUnlinkNode(request:context:)
      )

    case "MsgSubscribe":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgSubscribeRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgSubscribeResponse>(),
        interceptors: self.interceptors?.makeMsgSubscribeInterceptors() ?? [],
        userFunction: self.msgSubscribe(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Sentinel_Plan_V2_MsgServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Sentinel_Plan_V2_MsgServiceServerInterceptorFactoryProtocol? { get }

  func msgCreate(
    request: Sentinel_Plan_V2_MsgCreateRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Plan_V2_MsgCreateResponse

  func msgUpdateStatus(
    request: Sentinel_Plan_V2_MsgUpdateStatusRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Plan_V2_MsgUpdateStatusResponse

  func msgLinkNode(
    request: Sentinel_Plan_V2_MsgLinkNodeRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Plan_V2_MsgLinkNodeResponse

  func msgUnlinkNode(
    request: Sentinel_Plan_V2_MsgUnlinkNodeRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Plan_V2_MsgUnlinkNodeResponse

  func msgSubscribe(
    request: Sentinel_Plan_V2_MsgSubscribeRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Plan_V2_MsgSubscribeResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Plan_V2_MsgServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Sentinel_Plan_V2_MsgServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Sentinel_Plan_V2_MsgServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Sentinel_Plan_V2_MsgServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "MsgCreate":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgCreateRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgCreateResponse>(),
        interceptors: self.interceptors?.makeMsgCreateInterceptors() ?? [],
        wrapping: { try await self.msgCreate(request: $0, context: $1) }
      )

    case "MsgUpdateStatus":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgUpdateStatusRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgUpdateStatusResponse>(),
        interceptors: self.interceptors?.makeMsgUpdateStatusInterceptors() ?? [],
        wrapping: { try await self.msgUpdateStatus(request: $0, context: $1) }
      )

    case "MsgLinkNode":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgLinkNodeRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgLinkNodeResponse>(),
        interceptors: self.interceptors?.makeMsgLinkNodeInterceptors() ?? [],
        wrapping: { try await self.msgLinkNode(request: $0, context: $1) }
      )

    case "MsgUnlinkNode":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgUnlinkNodeRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgUnlinkNodeResponse>(),
        interceptors: self.interceptors?.makeMsgUnlinkNodeInterceptors() ?? [],
        wrapping: { try await self.msgUnlinkNode(request: $0, context: $1) }
      )

    case "MsgSubscribe":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Plan_V2_MsgSubscribeRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Plan_V2_MsgSubscribeResponse>(),
        interceptors: self.interceptors?.makeMsgSubscribeInterceptors() ?? [],
        wrapping: { try await self.msgSubscribe(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol Sentinel_Plan_V2_MsgServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'msgCreate'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgCreateInterceptors() -> [ServerInterceptor<Sentinel_Plan_V2_MsgCreateRequest, Sentinel_Plan_V2_MsgCreateResponse>]

  /// - Returns: Interceptors to use when handling 'msgUpdateStatus'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgUpdateStatusInterceptors() -> [ServerInterceptor<Sentinel_Plan_V2_MsgUpdateStatusRequest, Sentinel_Plan_V2_MsgUpdateStatusResponse>]

  /// - Returns: Interceptors to use when handling 'msgLinkNode'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgLinkNodeInterceptors() -> [ServerInterceptor<Sentinel_Plan_V2_MsgLinkNodeRequest, Sentinel_Plan_V2_MsgLinkNodeResponse>]

  /// - Returns: Interceptors to use when handling 'msgUnlinkNode'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgUnlinkNodeInterceptors() -> [ServerInterceptor<Sentinel_Plan_V2_MsgUnlinkNodeRequest, Sentinel_Plan_V2_MsgUnlinkNodeResponse>]

  /// - Returns: Interceptors to use when handling 'msgSubscribe'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeMsgSubscribeInterceptors() -> [ServerInterceptor<Sentinel_Plan_V2_MsgSubscribeRequest, Sentinel_Plan_V2_MsgSubscribeResponse>]
}

internal enum Sentinel_Plan_V2_MsgServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "MsgService",
    fullName: "sentinel.plan.v2.MsgService",
    methods: [
      Sentinel_Plan_V2_MsgServiceServerMetadata.Methods.msgCreate,
      Sentinel_Plan_V2_MsgServiceServerMetadata.Methods.msgUpdateStatus,
      Sentinel_Plan_V2_MsgServiceServerMetadata.Methods.msgLinkNode,
      Sentinel_Plan_V2_MsgServiceServerMetadata.Methods.msgUnlinkNode,
      Sentinel_Plan_V2_MsgServiceServerMetadata.Methods.msgSubscribe,
    ]
  )

  internal enum Methods {
    internal static let msgCreate = GRPCMethodDescriptor(
      name: "MsgCreate",
      path: "/sentinel.plan.v2.MsgService/MsgCreate",
      type: GRPCCallType.unary
    )

    internal static let msgUpdateStatus = GRPCMethodDescriptor(
      name: "MsgUpdateStatus",
      path: "/sentinel.plan.v2.MsgService/MsgUpdateStatus",
      type: GRPCCallType.unary
    )

    internal static let msgLinkNode = GRPCMethodDescriptor(
      name: "MsgLinkNode",
      path: "/sentinel.plan.v2.MsgService/MsgLinkNode",
      type: GRPCCallType.unary
    )

    internal static let msgUnlinkNode = GRPCMethodDescriptor(
      name: "MsgUnlinkNode",
      path: "/sentinel.plan.v2.MsgService/MsgUnlinkNode",
      type: GRPCCallType.unary
    )

    internal static let msgSubscribe = GRPCMethodDescriptor(
      name: "MsgSubscribe",
      path: "/sentinel.plan.v2.MsgService/MsgSubscribe",
      type: GRPCCallType.unary
    )
  }
}
