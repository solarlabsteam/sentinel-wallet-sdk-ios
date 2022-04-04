// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/plan/v1/msg.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// MsgAddRequest defines the SDK message for adding a plan
struct Sentinel_Plan_V1_MsgAddRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var price: [Cosmos_Base_V1beta1_Coin] = []

  var validity: SwiftProtobuf.Google_Protobuf_Duration {
    get {return _validity ?? SwiftProtobuf.Google_Protobuf_Duration()}
    set {_validity = newValue}
  }
  /// Returns true if `validity` has been explicitly set.
  var hasValidity: Bool {return self._validity != nil}
  /// Clears the value of `validity`. Subsequent reads from it will return its default value.
  mutating func clearValidity() {self._validity = nil}

  var bytes: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _validity: SwiftProtobuf.Google_Protobuf_Duration? = nil
}

/// MsgSetStatusRequest defines the SDK message for modifying the status of a
/// plan
struct Sentinel_Plan_V1_MsgSetStatusRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var id: UInt64 = 0

  var status: Sentinel_Types_V1_Status = .unspecified

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MsgAddNodeRequest defines the SDK message for adding a node to a plan
struct Sentinel_Plan_V1_MsgAddNodeRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var id: UInt64 = 0

  var address: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MsgRemoveNodeRequest defines the SDK message for removing a node from a plan
struct Sentinel_Plan_V1_MsgRemoveNodeRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var id: UInt64 = 0

  var address: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MsgAddResponse defines the response of message MsgRegisterRequest
struct Sentinel_Plan_V1_MsgAddResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MsgSetStatusResponse defines the response of message MsgSetStatusRequest
struct Sentinel_Plan_V1_MsgSetStatusResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MsgAddNodeResponse defines the response of message MsgAddNodeRequest
struct Sentinel_Plan_V1_MsgAddNodeResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MsgRemoveNodeResponse defines the response of message MsgRemoveNodeRequest
struct Sentinel_Plan_V1_MsgRemoveNodeResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Sentinel_Plan_V1_MsgAddRequest: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgSetStatusRequest: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgAddNodeRequest: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgRemoveNodeRequest: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgAddResponse: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgSetStatusResponse: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgAddNodeResponse: @unchecked Sendable {}
extension Sentinel_Plan_V1_MsgRemoveNodeResponse: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sentinel.plan.v1"

extension Sentinel_Plan_V1_MsgAddRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgAddRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "price"),
    3: .same(proto: "validity"),
    4: .same(proto: "bytes"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.price) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._validity) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.bytes) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 1)
    }
    if !self.price.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.price, fieldNumber: 2)
    }
    try { if let v = self._validity {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    if !self.bytes.isEmpty {
      try visitor.visitSingularStringField(value: self.bytes, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgAddRequest, rhs: Sentinel_Plan_V1_MsgAddRequest) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.price != rhs.price {return false}
    if lhs._validity != rhs._validity {return false}
    if lhs.bytes != rhs.bytes {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgSetStatusRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgSetStatusRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "id"),
    3: .same(proto: "status"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 3: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 1)
    }
    if self.id != 0 {
      try visitor.visitSingularUInt64Field(value: self.id, fieldNumber: 2)
    }
    if self.status != .unspecified {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgSetStatusRequest, rhs: Sentinel_Plan_V1_MsgSetStatusRequest) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.id != rhs.id {return false}
    if lhs.status != rhs.status {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgAddNodeRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgAddNodeRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "id"),
    3: .same(proto: "address"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.address) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 1)
    }
    if self.id != 0 {
      try visitor.visitSingularUInt64Field(value: self.id, fieldNumber: 2)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgAddNodeRequest, rhs: Sentinel_Plan_V1_MsgAddNodeRequest) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.id != rhs.id {return false}
    if lhs.address != rhs.address {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgRemoveNodeRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgRemoveNodeRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "id"),
    3: .same(proto: "address"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.address) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 1)
    }
    if self.id != 0 {
      try visitor.visitSingularUInt64Field(value: self.id, fieldNumber: 2)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgRemoveNodeRequest, rhs: Sentinel_Plan_V1_MsgRemoveNodeRequest) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.id != rhs.id {return false}
    if lhs.address != rhs.address {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgAddResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgAddResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgAddResponse, rhs: Sentinel_Plan_V1_MsgAddResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgSetStatusResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgSetStatusResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgSetStatusResponse, rhs: Sentinel_Plan_V1_MsgSetStatusResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgAddNodeResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgAddNodeResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgAddNodeResponse, rhs: Sentinel_Plan_V1_MsgAddNodeResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Plan_V1_MsgRemoveNodeResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MsgRemoveNodeResponse"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Plan_V1_MsgRemoveNodeResponse, rhs: Sentinel_Plan_V1_MsgRemoveNodeResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
