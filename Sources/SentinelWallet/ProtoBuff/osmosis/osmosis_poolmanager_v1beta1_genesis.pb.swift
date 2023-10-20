// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: osmosis/poolmanager/v1beta1/genesis.proto
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

/// Params holds parameters for the poolmanager module
struct Osmosis_Poolmanager_V1beta1_Params {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var poolCreationFee: [Cosmos_Base_V1beta1_Coin] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GenesisState defines the poolmanager module's genesis state.
struct Osmosis_Poolmanager_V1beta1_GenesisState {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// the next_pool_id
  var nextPoolID: UInt64 = 0

  /// params is the container of poolmanager parameters.
  var params: Osmosis_Poolmanager_V1beta1_Params {
    get {return _params ?? Osmosis_Poolmanager_V1beta1_Params()}
    set {_params = newValue}
  }
  /// Returns true if `params` has been explicitly set.
  var hasParams: Bool {return self._params != nil}
  /// Clears the value of `params`. Subsequent reads from it will return its default value.
  mutating func clearParams() {self._params = nil}

  /// pool_routes is the container of the mappings from pool id to pool type.
  var poolRoutes: [Osmosis_Poolmanager_V1beta1_ModuleRoute] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _params: Osmosis_Poolmanager_V1beta1_Params? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Osmosis_Poolmanager_V1beta1_Params: @unchecked Sendable {}
extension Osmosis_Poolmanager_V1beta1_GenesisState: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "osmosis.poolmanager.v1beta1"

extension Osmosis_Poolmanager_V1beta1_Params: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Params"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "pool_creation_fee"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.poolCreationFee) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.poolCreationFee.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.poolCreationFee, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Osmosis_Poolmanager_V1beta1_Params, rhs: Osmosis_Poolmanager_V1beta1_Params) -> Bool {
    if lhs.poolCreationFee != rhs.poolCreationFee {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Osmosis_Poolmanager_V1beta1_GenesisState: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GenesisState"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "next_pool_id"),
    2: .same(proto: "params"),
    3: .standard(proto: "pool_routes"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt64Field(value: &self.nextPoolID) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._params) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.poolRoutes) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.nextPoolID != 0 {
      try visitor.visitSingularUInt64Field(value: self.nextPoolID, fieldNumber: 1)
    }
    try { if let v = self._params {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if !self.poolRoutes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.poolRoutes, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Osmosis_Poolmanager_V1beta1_GenesisState, rhs: Osmosis_Poolmanager_V1beta1_GenesisState) -> Bool {
    if lhs.nextPoolID != rhs.nextPoolID {return false}
    if lhs._params != rhs._params {return false}
    if lhs.poolRoutes != rhs.poolRoutes {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
