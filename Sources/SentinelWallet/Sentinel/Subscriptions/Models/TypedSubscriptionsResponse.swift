//
//  TypedSubscriptionsResponse.swift
//
//
//  Created by Lika Vorobeva on 10.11.2023.
//

import Foundation
import SwiftProtobuf

public struct TypedSubscriptionsResponse {
    public var nodeSubscriptions: [Sentinel_Subscription_V2_NodeSubscription] = []
    public var planSubscriptions: [Sentinel_Subscription_V2_PlanSubscription] = []
    
    public var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init(from response: Sentinel_Subscription_V2_QuerySubscriptionsForAccountResponse) {
        self.nodeSubscriptions = response.subscriptions.compactMap {
            guard $0.typeURL.contains("Node") else { return nil }
            return try? Sentinel_Subscription_V2_NodeSubscription(serializedData: $0.value)
        }
        self.planSubscriptions = response.subscriptions.compactMap {
            guard $0.typeURL.contains("Plan") else { return nil }
            return try? Sentinel_Subscription_V2_PlanSubscription(serializedData: $0.value)
        }
        self.unknownFields = response.unknownFields
    }
}

private let _protobuf_package = "sentinel.subscription.v2"

extension TypedSubscriptionsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding  {
    public init() { }
    
    public static let protoMessageName: String = _protobuf_package + ".QuerySubscriptionsForAccountResponse"
    
    public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "nodeSubscriptions"),
        2: .same(proto: "planSubscriptions")
    ]
    
    mutating public func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try { try decoder.decodeRepeatedMessageField(value: &self.nodeSubscriptions) }()
            case 2: try { try decoder.decodeRepeatedMessageField(value: &self.planSubscriptions) }()
            default: break
            }
        }
    }
    
    public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every if/case branch local when no optimizations
        // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
        // https://github.com/apple/swift-protobuf/issues/1182
        if !self.nodeSubscriptions.isEmpty {
            try visitor.visitRepeatedMessageField(value: self.nodeSubscriptions, fieldNumber: 1)
        }
        if !self.planSubscriptions.isEmpty {
            try visitor.visitRepeatedMessageField(value: self.planSubscriptions, fieldNumber: 2)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static public func ==(lhs: TypedSubscriptionsResponse, rhs: TypedSubscriptionsResponse) -> Bool {
        if lhs.nodeSubscriptions != rhs.nodeSubscriptions {return false}
        if lhs.planSubscriptions != rhs.planSubscriptions {return false}
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}

