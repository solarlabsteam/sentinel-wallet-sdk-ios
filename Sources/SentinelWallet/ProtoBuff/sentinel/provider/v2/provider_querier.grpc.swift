//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: sentinel/provider/v2/querier.proto
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Sentinel_Provider_V2_QueryServiceClient`, then call methods of this protocol to make API calls.
internal protocol Sentinel_Provider_V2_QueryServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? { get }

  func queryProviders(
    _ request: Sentinel_Provider_V2_QueryProvidersRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Provider_V2_QueryProvidersRequest, Sentinel_Provider_V2_QueryProvidersResponse>

  func queryProvider(
    _ request: Sentinel_Provider_V2_QueryProviderRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Provider_V2_QueryProviderRequest, Sentinel_Provider_V2_QueryProviderResponse>

  func queryParams(
    _ request: Sentinel_Provider_V2_QueryParamsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Provider_V2_QueryParamsRequest, Sentinel_Provider_V2_QueryParamsResponse>
}

extension Sentinel_Provider_V2_QueryServiceClientProtocol {
  internal var serviceName: String {
    return "sentinel.provider.v2.QueryService"
  }

  /// Unary call to QueryProviders
  ///
  /// - Parameters:
  ///   - request: Request to send to QueryProviders.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func queryProviders(
    _ request: Sentinel_Provider_V2_QueryProvidersRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Provider_V2_QueryProvidersRequest, Sentinel_Provider_V2_QueryProvidersResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProviders.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryProvidersInterceptors() ?? []
    )
  }

  /// Unary call to QueryProvider
  ///
  /// - Parameters:
  ///   - request: Request to send to QueryProvider.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func queryProvider(
    _ request: Sentinel_Provider_V2_QueryProviderRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Provider_V2_QueryProviderRequest, Sentinel_Provider_V2_QueryProviderResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProvider.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryProviderInterceptors() ?? []
    )
  }

  /// Unary call to QueryParams
  ///
  /// - Parameters:
  ///   - request: Request to send to QueryParams.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func queryParams(
    _ request: Sentinel_Provider_V2_QueryParamsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Provider_V2_QueryParamsRequest, Sentinel_Provider_V2_QueryParamsResponse> {
    return self.makeUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryParams.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Sentinel_Provider_V2_QueryServiceClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Sentinel_Provider_V2_QueryServiceNIOClient")
internal final class Sentinel_Provider_V2_QueryServiceClient: Sentinel_Provider_V2_QueryServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the sentinel.provider.v2.QueryService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Sentinel_Provider_V2_QueryServiceNIOClient: Sentinel_Provider_V2_QueryServiceClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the sentinel.provider.v2.QueryService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Sentinel_Provider_V2_QueryServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? { get }

  func makeQueryProvidersCall(
    _ request: Sentinel_Provider_V2_QueryProvidersRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Provider_V2_QueryProvidersRequest, Sentinel_Provider_V2_QueryProvidersResponse>

  func makeQueryProviderCall(
    _ request: Sentinel_Provider_V2_QueryProviderRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Provider_V2_QueryProviderRequest, Sentinel_Provider_V2_QueryProviderResponse>

  func makeQueryParamsCall(
    _ request: Sentinel_Provider_V2_QueryParamsRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Sentinel_Provider_V2_QueryParamsRequest, Sentinel_Provider_V2_QueryParamsResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Provider_V2_QueryServiceAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Sentinel_Provider_V2_QueryServiceClientMetadata.serviceDescriptor
  }

  internal var interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeQueryProvidersCall(
    _ request: Sentinel_Provider_V2_QueryProvidersRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Provider_V2_QueryProvidersRequest, Sentinel_Provider_V2_QueryProvidersResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProviders.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryProvidersInterceptors() ?? []
    )
  }

  internal func makeQueryProviderCall(
    _ request: Sentinel_Provider_V2_QueryProviderRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Provider_V2_QueryProviderRequest, Sentinel_Provider_V2_QueryProviderResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProvider.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryProviderInterceptors() ?? []
    )
  }

  internal func makeQueryParamsCall(
    _ request: Sentinel_Provider_V2_QueryParamsRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Sentinel_Provider_V2_QueryParamsRequest, Sentinel_Provider_V2_QueryParamsResponse> {
    return self.makeAsyncUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryParams.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Provider_V2_QueryServiceAsyncClientProtocol {
  internal func queryProviders(
    _ request: Sentinel_Provider_V2_QueryProvidersRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Provider_V2_QueryProvidersResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProviders.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryProvidersInterceptors() ?? []
    )
  }

  internal func queryProvider(
    _ request: Sentinel_Provider_V2_QueryProviderRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Provider_V2_QueryProviderResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProvider.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryProviderInterceptors() ?? []
    )
  }

  internal func queryParams(
    _ request: Sentinel_Provider_V2_QueryParamsRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Sentinel_Provider_V2_QueryParamsResponse {
    return try await self.performAsyncUnaryCall(
      path: Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryParams.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Sentinel_Provider_V2_QueryServiceAsyncClient: Sentinel_Provider_V2_QueryServiceAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Sentinel_Provider_V2_QueryServiceClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'queryProviders'.
  func makeQueryProvidersInterceptors() -> [ClientInterceptor<Sentinel_Provider_V2_QueryProvidersRequest, Sentinel_Provider_V2_QueryProvidersResponse>]

  /// - Returns: Interceptors to use when invoking 'queryProvider'.
  func makeQueryProviderInterceptors() -> [ClientInterceptor<Sentinel_Provider_V2_QueryProviderRequest, Sentinel_Provider_V2_QueryProviderResponse>]

  /// - Returns: Interceptors to use when invoking 'queryParams'.
  func makeQueryParamsInterceptors() -> [ClientInterceptor<Sentinel_Provider_V2_QueryParamsRequest, Sentinel_Provider_V2_QueryParamsResponse>]
}

internal enum Sentinel_Provider_V2_QueryServiceClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "QueryService",
    fullName: "sentinel.provider.v2.QueryService",
    methods: [
      Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProviders,
      Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryProvider,
      Sentinel_Provider_V2_QueryServiceClientMetadata.Methods.queryParams,
    ]
  )

  internal enum Methods {
    internal static let queryProviders = GRPCMethodDescriptor(
      name: "QueryProviders",
      path: "/sentinel.provider.v2.QueryService/QueryProviders",
      type: GRPCCallType.unary
    )

    internal static let queryProvider = GRPCMethodDescriptor(
      name: "QueryProvider",
      path: "/sentinel.provider.v2.QueryService/QueryProvider",
      type: GRPCCallType.unary
    )

    internal static let queryParams = GRPCMethodDescriptor(
      name: "QueryParams",
      path: "/sentinel.provider.v2.QueryService/QueryParams",
      type: GRPCCallType.unary
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Sentinel_Provider_V2_QueryServiceProvider: CallHandlerProvider {
  var interceptors: Sentinel_Provider_V2_QueryServiceServerInterceptorFactoryProtocol? { get }

  func queryProviders(request: Sentinel_Provider_V2_QueryProvidersRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Provider_V2_QueryProvidersResponse>

  func queryProvider(request: Sentinel_Provider_V2_QueryProviderRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Provider_V2_QueryProviderResponse>

  func queryParams(request: Sentinel_Provider_V2_QueryParamsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Provider_V2_QueryParamsResponse>
}

extension Sentinel_Provider_V2_QueryServiceProvider {
  internal var serviceName: Substring {
    return Sentinel_Provider_V2_QueryServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "QueryProviders":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Provider_V2_QueryProvidersRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Provider_V2_QueryProvidersResponse>(),
        interceptors: self.interceptors?.makeQueryProvidersInterceptors() ?? [],
        userFunction: self.queryProviders(request:context:)
      )

    case "QueryProvider":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Provider_V2_QueryProviderRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Provider_V2_QueryProviderResponse>(),
        interceptors: self.interceptors?.makeQueryProviderInterceptors() ?? [],
        userFunction: self.queryProvider(request:context:)
      )

    case "QueryParams":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Provider_V2_QueryParamsRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Provider_V2_QueryParamsResponse>(),
        interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? [],
        userFunction: self.queryParams(request:context:)
      )

    default:
      return nil
    }
  }
}

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Sentinel_Provider_V2_QueryServiceAsyncProvider: CallHandlerProvider, Sendable {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Sentinel_Provider_V2_QueryServiceServerInterceptorFactoryProtocol? { get }

  func queryProviders(
    request: Sentinel_Provider_V2_QueryProvidersRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Provider_V2_QueryProvidersResponse

  func queryProvider(
    request: Sentinel_Provider_V2_QueryProviderRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Provider_V2_QueryProviderResponse

  func queryParams(
    request: Sentinel_Provider_V2_QueryParamsRequest,
    context: GRPCAsyncServerCallContext
  ) async throws -> Sentinel_Provider_V2_QueryParamsResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Sentinel_Provider_V2_QueryServiceAsyncProvider {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Sentinel_Provider_V2_QueryServiceServerMetadata.serviceDescriptor
  }

  internal var serviceName: Substring {
    return Sentinel_Provider_V2_QueryServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  internal var interceptors: Sentinel_Provider_V2_QueryServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "QueryProviders":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Provider_V2_QueryProvidersRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Provider_V2_QueryProvidersResponse>(),
        interceptors: self.interceptors?.makeQueryProvidersInterceptors() ?? [],
        wrapping: { try await self.queryProviders(request: $0, context: $1) }
      )

    case "QueryProvider":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Provider_V2_QueryProviderRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Provider_V2_QueryProviderResponse>(),
        interceptors: self.interceptors?.makeQueryProviderInterceptors() ?? [],
        wrapping: { try await self.queryProvider(request: $0, context: $1) }
      )

    case "QueryParams":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Provider_V2_QueryParamsRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Provider_V2_QueryParamsResponse>(),
        interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? [],
        wrapping: { try await self.queryParams(request: $0, context: $1) }
      )

    default:
      return nil
    }
  }
}

internal protocol Sentinel_Provider_V2_QueryServiceServerInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when handling 'queryProviders'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQueryProvidersInterceptors() -> [ServerInterceptor<Sentinel_Provider_V2_QueryProvidersRequest, Sentinel_Provider_V2_QueryProvidersResponse>]

  /// - Returns: Interceptors to use when handling 'queryProvider'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQueryProviderInterceptors() -> [ServerInterceptor<Sentinel_Provider_V2_QueryProviderRequest, Sentinel_Provider_V2_QueryProviderResponse>]

  /// - Returns: Interceptors to use when handling 'queryParams'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQueryParamsInterceptors() -> [ServerInterceptor<Sentinel_Provider_V2_QueryParamsRequest, Sentinel_Provider_V2_QueryParamsResponse>]
}

internal enum Sentinel_Provider_V2_QueryServiceServerMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "QueryService",
    fullName: "sentinel.provider.v2.QueryService",
    methods: [
      Sentinel_Provider_V2_QueryServiceServerMetadata.Methods.queryProviders,
      Sentinel_Provider_V2_QueryServiceServerMetadata.Methods.queryProvider,
      Sentinel_Provider_V2_QueryServiceServerMetadata.Methods.queryParams,
    ]
  )

  internal enum Methods {
    internal static let queryProviders = GRPCMethodDescriptor(
      name: "QueryProviders",
      path: "/sentinel.provider.v2.QueryService/QueryProviders",
      type: GRPCCallType.unary
    )

    internal static let queryProvider = GRPCMethodDescriptor(
      name: "QueryProvider",
      path: "/sentinel.provider.v2.QueryService/QueryProvider",
      type: GRPCCallType.unary
    )

    internal static let queryParams = GRPCMethodDescriptor(
      name: "QueryParams",
      path: "/sentinel.provider.v2.QueryService/QueryParams",
      type: GRPCCallType.unary
    )
  }
}
