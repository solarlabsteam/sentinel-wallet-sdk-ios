// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/provider/v2/provider.proto
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

struct Sentinel_Provider_V2_Provider {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var address: String = String()

  var name: String = String()

  var identity: String = String()

  var website: String = String()

  var description_p: String = String()

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
extension Sentinel_Provider_V2_Provider: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sentinel.provider.v2"

extension Sentinel_Provider_V2_Provider: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Provider"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "address"),
    2: .same(proto: "name"),
    3: .same(proto: "identity"),
    4: .same(proto: "website"),
    5: .same(proto: "description"),
    6: .same(proto: "status"),
    7: .standard(proto: "status_at"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.address) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.identity) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.website) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.description_p) }()
      case 6: try { try decoder.decodeSingularEnumField(value: &self.status) }()
      case 7: try { try decoder.decodeSingularMessageField(value: &self._statusAt) }()
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
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    if !self.identity.isEmpty {
      try visitor.visitSingularStringField(value: self.identity, fieldNumber: 3)
    }
    if !self.website.isEmpty {
      try visitor.visitSingularStringField(value: self.website, fieldNumber: 4)
    }
    if !self.description_p.isEmpty {
      try visitor.visitSingularStringField(value: self.description_p, fieldNumber: 5)
    }
    if self.status != .unspecified {
      try visitor.visitSingularEnumField(value: self.status, fieldNumber: 6)
    }
    try { if let v = self._statusAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Provider_V2_Provider, rhs: Sentinel_Provider_V2_Provider) -> Bool {
    if lhs.address != rhs.address {return false}
    if lhs.name != rhs.name {return false}
    if lhs.identity != rhs.identity {return false}
    if lhs.website != rhs.website {return false}
    if lhs.description_p != rhs.description_p {return false}
    if lhs.status != rhs.status {return false}
    if lhs._statusAt != rhs._statusAt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
