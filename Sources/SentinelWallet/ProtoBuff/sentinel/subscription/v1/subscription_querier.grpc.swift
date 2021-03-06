//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: sentinel/subscription/v1/querier.proto
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


/// Usage: instantiate `Sentinel_Subscription_V1_QueryServiceClient`, then call methods of this protocol to make API calls.
internal protocol Sentinel_Subscription_V1_QueryServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Sentinel_Subscription_V1_QueryServiceClientInterceptorFactoryProtocol? { get }

  func querySubscriptions(
    _ request: Sentinel_Subscription_V1_QuerySubscriptionsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V1_QuerySubscriptionsRequest, Sentinel_Subscription_V1_QuerySubscriptionsResponse>

  func querySubscriptionsForAddress(
    _ request: Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest, Sentinel_Subscription_V1_QuerySubscriptionsForAddressResponse>

  func querySubscription(
    _ request: Sentinel_Subscription_V1_QuerySubscriptionRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V1_QuerySubscriptionRequest, Sentinel_Subscription_V1_QuerySubscriptionResponse>

  func queryQuota(
    _ request: Sentinel_Subscription_V1_QueryQuotaRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V1_QueryQuotaRequest, Sentinel_Subscription_V1_QueryQuotaResponse>

  func queryQuotas(
    _ request: Sentinel_Subscription_V1_QueryQuotasRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V1_QueryQuotasRequest, Sentinel_Subscription_V1_QueryQuotasResponse>

  func queryParams(
    _ request: Sentinel_Subscription_V1_QueryParamsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Sentinel_Subscription_V1_QueryParamsRequest, Sentinel_Subscription_V1_QueryParamsResponse>
}

extension Sentinel_Subscription_V1_QueryServiceClientProtocol {
  internal var serviceName: String {
    return "sentinel.subscription.v1.QueryService"
  }

  /// Unary call to QuerySubscriptions
  ///
  /// - Parameters:
  ///   - request: Request to send to QuerySubscriptions.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func querySubscriptions(
    _ request: Sentinel_Subscription_V1_QuerySubscriptionsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V1_QuerySubscriptionsRequest, Sentinel_Subscription_V1_QuerySubscriptionsResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v1.QueryService/QuerySubscriptions",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQuerySubscriptionsInterceptors() ?? []
    )
  }

  /// Unary call to QuerySubscriptionsForAddress
  ///
  /// - Parameters:
  ///   - request: Request to send to QuerySubscriptionsForAddress.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func querySubscriptionsForAddress(
    _ request: Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest, Sentinel_Subscription_V1_QuerySubscriptionsForAddressResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v1.QueryService/QuerySubscriptionsForAddress",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQuerySubscriptionsForAddressInterceptors() ?? []
    )
  }

  /// Unary call to QuerySubscription
  ///
  /// - Parameters:
  ///   - request: Request to send to QuerySubscription.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func querySubscription(
    _ request: Sentinel_Subscription_V1_QuerySubscriptionRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V1_QuerySubscriptionRequest, Sentinel_Subscription_V1_QuerySubscriptionResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v1.QueryService/QuerySubscription",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQuerySubscriptionInterceptors() ?? []
    )
  }

  /// Unary call to QueryQuota
  ///
  /// - Parameters:
  ///   - request: Request to send to QueryQuota.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func queryQuota(
    _ request: Sentinel_Subscription_V1_QueryQuotaRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V1_QueryQuotaRequest, Sentinel_Subscription_V1_QueryQuotaResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v1.QueryService/QueryQuota",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryQuotaInterceptors() ?? []
    )
  }

  /// Unary call to QueryQuotas
  ///
  /// - Parameters:
  ///   - request: Request to send to QueryQuotas.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func queryQuotas(
    _ request: Sentinel_Subscription_V1_QueryQuotasRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V1_QueryQuotasRequest, Sentinel_Subscription_V1_QueryQuotasResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v1.QueryService/QueryQuotas",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryQuotasInterceptors() ?? []
    )
  }

  /// Unary call to QueryParams
  ///
  /// - Parameters:
  ///   - request: Request to send to QueryParams.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func queryParams(
    _ request: Sentinel_Subscription_V1_QueryParamsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sentinel_Subscription_V1_QueryParamsRequest, Sentinel_Subscription_V1_QueryParamsResponse> {
    return self.makeUnaryCall(
      path: "/sentinel.subscription.v1.QueryService/QueryParams",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? []
    )
  }
}

internal protocol Sentinel_Subscription_V1_QueryServiceClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'querySubscriptions'.
  func makeQuerySubscriptionsInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V1_QuerySubscriptionsRequest, Sentinel_Subscription_V1_QuerySubscriptionsResponse>]

  /// - Returns: Interceptors to use when invoking 'querySubscriptionsForAddress'.
  func makeQuerySubscriptionsForAddressInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest, Sentinel_Subscription_V1_QuerySubscriptionsForAddressResponse>]

  /// - Returns: Interceptors to use when invoking 'querySubscription'.
  func makeQuerySubscriptionInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V1_QuerySubscriptionRequest, Sentinel_Subscription_V1_QuerySubscriptionResponse>]

  /// - Returns: Interceptors to use when invoking 'queryQuota'.
  func makeQueryQuotaInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V1_QueryQuotaRequest, Sentinel_Subscription_V1_QueryQuotaResponse>]

  /// - Returns: Interceptors to use when invoking 'queryQuotas'.
  func makeQueryQuotasInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V1_QueryQuotasRequest, Sentinel_Subscription_V1_QueryQuotasResponse>]

  /// - Returns: Interceptors to use when invoking 'queryParams'.
  func makeQueryParamsInterceptors() -> [ClientInterceptor<Sentinel_Subscription_V1_QueryParamsRequest, Sentinel_Subscription_V1_QueryParamsResponse>]
}

internal final class Sentinel_Subscription_V1_QueryServiceClient: Sentinel_Subscription_V1_QueryServiceClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sentinel_Subscription_V1_QueryServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the sentinel.subscription.v1.QueryService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sentinel_Subscription_V1_QueryServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Sentinel_Subscription_V1_QueryServiceProvider: CallHandlerProvider {
  var interceptors: Sentinel_Subscription_V1_QueryServiceServerInterceptorFactoryProtocol? { get }

  func querySubscriptions(request: Sentinel_Subscription_V1_QuerySubscriptionsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V1_QuerySubscriptionsResponse>

  func querySubscriptionsForAddress(request: Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V1_QuerySubscriptionsForAddressResponse>

  func querySubscription(request: Sentinel_Subscription_V1_QuerySubscriptionRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V1_QuerySubscriptionResponse>

  func queryQuota(request: Sentinel_Subscription_V1_QueryQuotaRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V1_QueryQuotaResponse>

  func queryQuotas(request: Sentinel_Subscription_V1_QueryQuotasRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V1_QueryQuotasResponse>

  func queryParams(request: Sentinel_Subscription_V1_QueryParamsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Sentinel_Subscription_V1_QueryParamsResponse>
}

extension Sentinel_Subscription_V1_QueryServiceProvider {
  internal var serviceName: Substring { return "sentinel.subscription.v1.QueryService" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "QuerySubscriptions":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V1_QuerySubscriptionsRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V1_QuerySubscriptionsResponse>(),
        interceptors: self.interceptors?.makeQuerySubscriptionsInterceptors() ?? [],
        userFunction: self.querySubscriptions(request:context:)
      )

    case "QuerySubscriptionsForAddress":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V1_QuerySubscriptionsForAddressResponse>(),
        interceptors: self.interceptors?.makeQuerySubscriptionsForAddressInterceptors() ?? [],
        userFunction: self.querySubscriptionsForAddress(request:context:)
      )

    case "QuerySubscription":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V1_QuerySubscriptionRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V1_QuerySubscriptionResponse>(),
        interceptors: self.interceptors?.makeQuerySubscriptionInterceptors() ?? [],
        userFunction: self.querySubscription(request:context:)
      )

    case "QueryQuota":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V1_QueryQuotaRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V1_QueryQuotaResponse>(),
        interceptors: self.interceptors?.makeQueryQuotaInterceptors() ?? [],
        userFunction: self.queryQuota(request:context:)
      )

    case "QueryQuotas":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V1_QueryQuotasRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V1_QueryQuotasResponse>(),
        interceptors: self.interceptors?.makeQueryQuotasInterceptors() ?? [],
        userFunction: self.queryQuotas(request:context:)
      )

    case "QueryParams":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sentinel_Subscription_V1_QueryParamsRequest>(),
        responseSerializer: ProtobufSerializer<Sentinel_Subscription_V1_QueryParamsResponse>(),
        interceptors: self.interceptors?.makeQueryParamsInterceptors() ?? [],
        userFunction: self.queryParams(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Sentinel_Subscription_V1_QueryServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'querySubscriptions'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQuerySubscriptionsInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V1_QuerySubscriptionsRequest, Sentinel_Subscription_V1_QuerySubscriptionsResponse>]

  /// - Returns: Interceptors to use when handling 'querySubscriptionsForAddress'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQuerySubscriptionsForAddressInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V1_QuerySubscriptionsForAddressRequest, Sentinel_Subscription_V1_QuerySubscriptionsForAddressResponse>]

  /// - Returns: Interceptors to use when handling 'querySubscription'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQuerySubscriptionInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V1_QuerySubscriptionRequest, Sentinel_Subscription_V1_QuerySubscriptionResponse>]

  /// - Returns: Interceptors to use when handling 'queryQuota'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQueryQuotaInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V1_QueryQuotaRequest, Sentinel_Subscription_V1_QueryQuotaResponse>]

  /// - Returns: Interceptors to use when handling 'queryQuotas'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQueryQuotasInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V1_QueryQuotasRequest, Sentinel_Subscription_V1_QueryQuotasResponse>]

  /// - Returns: Interceptors to use when handling 'queryParams'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeQueryParamsInterceptors() -> [ServerInterceptor<Sentinel_Subscription_V1_QueryParamsRequest, Sentinel_Subscription_V1_QueryParamsResponse>]
}
