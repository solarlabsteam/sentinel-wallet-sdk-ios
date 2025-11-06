//
//  TypedSessionResponse.swift
//  SentinelWallet
//
//  Created by Lika Vorobeva on 06.11.2025.
//


import Foundation
import SwiftProtobuf

public struct TypedSessionResponse {
    public var sessions: [Sentinel_Subscription_V3_Session] = []
    
    public var unknownFields = SwiftProtobuf.UnknownStorage()
    
    init(from response: Sentinel_Session_V3_QuerySessionsForAccountResponse) {
        self.sessions = response.sessions.compactMap { try? Sentinel_Subscription_V3_Session(serializedData: $0.value) }
        self.unknownFields = response.unknownFields
    }
}

private let _protobuf_package = "sentinel.sessions.v3"

extension TypedSessionResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding  {
    public init() { }
    
    public static let protoMessageName: String = _protobuf_package + ".QuerySessionsForAccountResponse"
    
    public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        1: .same(proto: "sessions")
    ]
    
    mutating public func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
        while let fieldNumber = try decoder.nextFieldNumber() {
            // The use of inline closures is to circumvent an issue where the compiler
            // allocates stack space for every case branch when no optimizations are
            // enabled. https://github.com/apple/swift-protobuf/issues/1034
            switch fieldNumber {
            case 1: try { try decoder.decodeRepeatedMessageField(value: &self.sessions) }()
            default: break
            }
        }
    }
    
    public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every if/case branch local when no optimizations
        // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
        // https://github.com/apple/swift-protobuf/issues/1182
        if !self.sessions.isEmpty {
            try visitor.visitRepeatedMessageField(value: self.sessions, fieldNumber: 1)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    static public func ==(lhs: TypedSessionResponse, rhs: TypedSessionResponse) -> Bool {
        if lhs.sessions != rhs.sessions {return false}
        if lhs.unknownFields != rhs.unknownFields {return false}
        return true
    }
}
