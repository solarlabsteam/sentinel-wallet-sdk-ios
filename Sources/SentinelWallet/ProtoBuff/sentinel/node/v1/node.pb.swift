// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/node/v1/node.proto
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

struct Sentinel_Node_V1_Node {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var address: String = String()

  var provider: String = String()

  var price: [Cosmos_Base_V1beta1_Coin] = []

  var remoteURL: String = String()

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

  fileprivate var _statusAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Sentinel_Node_V1_Node: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sentinel.node.v1"

extension Sentinel_Node_V1_Node: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Node"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "address"),
    2: .same(proto: "provider"),
    3: .same(proto: "price"),
    4: .standard(proto: "remote_url"),
    5: .same(proto: "status"),
    6: .standard(proto: "status_at"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.address) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.provider) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.price) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.remoteURL) }()
      case 5: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._statusAt) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 1)
    }
    if !self.provider.isEmpty {
      try visitor.visitSingularStringField(value: self.provider, fieldNumber: 2)
    }
    if !self.price.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.price, fieldNumber: 3)
    }
    if !self.remoteURL.isEmpty {
      try visitor.visitSingularStringField(value: self.remoteURL, fieldNumber: 4)
    }
    if self.status != .unspecified {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 5)
    }
    try { if let v = self._statusAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Node_V1_Node, rhs: Sentinel_Node_V1_Node) -> Bool {
    if lhs.address != rhs.address {return false}
    if lhs.provider != rhs.provider {return false}
    if lhs.price != rhs.price {return false}
    if lhs.remoteURL != rhs.remoteURL {return false}
    if lhs.status != rhs.status {return false}
    if lhs._statusAt != rhs._statusAt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
