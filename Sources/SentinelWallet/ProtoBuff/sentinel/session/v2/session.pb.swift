// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/session/v2/session.proto
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

struct Sentinel_Session_V2_Session {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: UInt64 = 0

  var subscriptionID: UInt64 = 0

  var nodeAddress: String = String()

  var address: String = String()

  var bandwidth: Sentinel_Types_V1_Bandwidth {
    get {return _bandwidth ?? Sentinel_Types_V1_Bandwidth()}
    set {_bandwidth = newValue}
  }
  /// Returns true if `bandwidth` has been explicitly set.
  var hasBandwidth: Bool {return self._bandwidth != nil}
  /// Clears the value of `bandwidth`. Subsequent reads from it will return its default value.
  mutating func clearBandwidth() {self._bandwidth = nil}

  var duration: SwiftProtobuf.Google_Protobuf_Duration {
    get {return _duration ?? SwiftProtobuf.Google_Protobuf_Duration()}
    set {_duration = newValue}
  }
  /// Returns true if `duration` has been explicitly set.
  var hasDuration: Bool {return self._duration != nil}
  /// Clears the value of `duration`. Subsequent reads from it will return its default value.
  mutating func clearDuration() {self._duration = nil}

  var inactiveAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _inactiveAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_inactiveAt = newValue}
  }
  /// Returns true if `inactiveAt` has been explicitly set.
  var hasInactiveAt: Bool {return self._inactiveAt != nil}
  /// Clears the value of `inactiveAt`. Subsequent reads from it will return its default value.
  mutating func clearInactiveAt() {self._inactiveAt = nil}

  var status: Sentinel_Types_V1_Status = .unspecified

  var statusAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _statusAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_statusAt = newValue}
  }
  /// Returns true if `statusAt` has been explicitly set.
  var hasStatusAt: Bool {return self._statusAt != nil}
  /// Clears the value of `statusAt`. Subsequent reads from it will return its default value.
  mutating func clearStatusAt() {self._statusAt = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _bandwidth: Sentinel_Types_V1_Bandwidth? = nil
  fileprivate var _duration: SwiftProtobuf.Google_Protobuf_Duration? = nil
  fileprivate var _inactiveAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _statusAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Sentinel_Session_V2_Session: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sentinel.session.v2"

extension Sentinel_Session_V2_Session: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Session"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .standard(proto: "subscription_id"),
    3: .standard(proto: "node_address"),
    4: .same(proto: "address"),
    5: .same(proto: "bandwidth"),
    6: .same(proto: "duration"),
    7: .standard(proto: "inactive_at"),
    8: .same(proto: "status"),
    9: .standard(proto: "status_at"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.subscriptionID) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.nodeAddress) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.address) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._bandwidth) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._duration) }()
      case 7: try { try decoder.decodeSingularMessageField(value: &self._inactiveAt) }()
      case 8: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      case 9: try { try decoder.decodeSingularMessageField(value: &self._statusAt) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.id != 0 {
      try visitor.visitSingularUInt64Field(value: self.id, fieldNumber: 1)
    }
    if self.subscriptionID != 0 {
      try visitor.visitSingularUInt64Field(value: self.subscriptionID, fieldNumber: 2)
    }
    if !self.nodeAddress.isEmpty {
      try visitor.visitSingularStringField(value: self.nodeAddress, fieldNumber: 3)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 4)
    }
    try { if let v = self._bandwidth {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._duration {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._inactiveAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    } }()
    if self.status != .unspecified {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 8)
    }
    try { if let v = self._statusAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Session_V2_Session, rhs: Sentinel_Session_V2_Session) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.subscriptionID != rhs.subscriptionID {return false}
    if lhs.nodeAddress != rhs.nodeAddress {return false}
    if lhs.address != rhs.address {return false}
    if lhs._bandwidth != rhs._bandwidth {return false}
    if lhs._duration != rhs._duration {return false}
    if lhs._inactiveAt != rhs._inactiveAt {return false}
    if lhs.status != rhs.status {return false}
    if lhs._statusAt != rhs._statusAt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
