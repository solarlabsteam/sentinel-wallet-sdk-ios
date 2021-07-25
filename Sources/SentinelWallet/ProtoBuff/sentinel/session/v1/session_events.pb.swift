// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/session/v1/events.proto
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

struct Sentinel_Session_V1_EventModule {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Sentinel_Session_V1_EventSetSessionCount {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var count: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Sentinel_Session_V1_EventStartSession {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var id: UInt64 = 0

  var subscription: UInt64 = 0

  var node: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Sentinel_Session_V1_EventUpdateSession {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var id: UInt64 = 0

  var subscription: UInt64 = 0

  var node: String = String()

  var address: String = String()

  var duration: SwiftProtobuf.Google_Protobuf_Duration {
    get {return _duration ?? SwiftProtobuf.Google_Protobuf_Duration()}
    set {_duration = newValue}
  }
  /// Returns true if `duration` has been explicitly set.
  var hasDuration: Bool {return self._duration != nil}
  /// Clears the value of `duration`. Subsequent reads from it will return its default value.
  mutating func clearDuration() {self._duration = nil}

  var bandwidth: Sentinel_Types_V1_Bandwidth {
    get {return _bandwidth ?? Sentinel_Types_V1_Bandwidth()}
    set {_bandwidth = newValue}
  }
  /// Returns true if `bandwidth` has been explicitly set.
  var hasBandwidth: Bool {return self._bandwidth != nil}
  /// Clears the value of `bandwidth`. Subsequent reads from it will return its default value.
  mutating func clearBandwidth() {self._bandwidth = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _duration: SwiftProtobuf.Google_Protobuf_Duration? = nil
  fileprivate var _bandwidth: Sentinel_Types_V1_Bandwidth? = nil
}

struct Sentinel_Session_V1_EventEndSession {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var from: String = String()

  var id: UInt64 = 0

  var subscription: UInt64 = 0

  var node: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sentinel.session.v1"

extension Sentinel_Session_V1_EventModule: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".EventModule"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Session_V1_EventModule, rhs: Sentinel_Session_V1_EventModule) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Session_V1_EventSetSessionCount: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".EventSetSessionCount"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "count"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self.count) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.count != 0 {
      try visitor.visitSingularUInt64Field(value: self.count, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Session_V1_EventSetSessionCount, rhs: Sentinel_Session_V1_EventSetSessionCount) -> Bool {
    if lhs.count != rhs.count {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Session_V1_EventStartSession: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".EventStartSession"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "id"),
    3: .same(proto: "subscription"),
    4: .same(proto: "node"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.subscription) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.node) }()
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
    if self.subscription != 0 {
      try visitor.visitSingularUInt64Field(value: self.subscription, fieldNumber: 3)
    }
    if !self.node.isEmpty {
      try visitor.visitSingularStringField(value: self.node, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Session_V1_EventStartSession, rhs: Sentinel_Session_V1_EventStartSession) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.id != rhs.id {return false}
    if lhs.subscription != rhs.subscription {return false}
    if lhs.node != rhs.node {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Session_V1_EventUpdateSession: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".EventUpdateSession"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "id"),
    3: .same(proto: "subscription"),
    4: .same(proto: "node"),
    5: .same(proto: "address"),
    6: .same(proto: "duration"),
    7: .same(proto: "bandwidth"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.subscription) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.node) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.address) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._duration) }()
      case 7: try { try decoder.decodeSingularMessageField(value: &self._bandwidth) }()
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
    if self.subscription != 0 {
      try visitor.visitSingularUInt64Field(value: self.subscription, fieldNumber: 3)
    }
    if !self.node.isEmpty {
      try visitor.visitSingularStringField(value: self.node, fieldNumber: 4)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 5)
    }
    if let v = self._duration {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    }
    if let v = self._bandwidth {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Session_V1_EventUpdateSession, rhs: Sentinel_Session_V1_EventUpdateSession) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.id != rhs.id {return false}
    if lhs.subscription != rhs.subscription {return false}
    if lhs.node != rhs.node {return false}
    if lhs.address != rhs.address {return false}
    if lhs._duration != rhs._duration {return false}
    if lhs._bandwidth != rhs._bandwidth {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Sentinel_Session_V1_EventEndSession: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".EventEndSession"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "from"),
    2: .same(proto: "id"),
    3: .same(proto: "subscription"),
    4: .same(proto: "node"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.subscription) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.node) }()
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
    if self.subscription != 0 {
      try visitor.visitSingularUInt64Field(value: self.subscription, fieldNumber: 3)
    }
    if !self.node.isEmpty {
      try visitor.visitSingularStringField(value: self.node, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Session_V1_EventEndSession, rhs: Sentinel_Session_V1_EventEndSession) -> Bool {
    if lhs.from != rhs.from {return false}
    if lhs.id != rhs.id {return false}
    if lhs.subscription != rhs.subscription {return false}
    if lhs.node != rhs.node {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}