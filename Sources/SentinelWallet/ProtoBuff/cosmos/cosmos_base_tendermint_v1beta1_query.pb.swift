// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: cosmos/base/tendermint/v1beta1/query.proto
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

/// GetValidatorSetByHeightRequest is the request type for the Query/GetValidatorSetByHeight RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var height: Int64 = 0

  /// pagination defines an pagination for the request.
  var pagination: Cosmos_Base_Query_V1beta1_PageRequest {
    get {return _pagination ?? Cosmos_Base_Query_V1beta1_PageRequest()}
    set {_pagination = newValue}
  }
  /// Returns true if `pagination` has been explicitly set.
  var hasPagination: Bool {return self._pagination != nil}
  /// Clears the value of `pagination`. Subsequent reads from it will return its default value.
  mutating func clearPagination() {self._pagination = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _pagination: Cosmos_Base_Query_V1beta1_PageRequest? = nil
}

/// GetValidatorSetByHeightResponse is the response type for the Query/GetValidatorSetByHeight RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockHeight: Int64 = 0

  var validators: [Cosmos_Base_Tendermint_V1beta1_Validator] = []

  /// pagination defines an pagination for the response.
  var pagination: Cosmos_Base_Query_V1beta1_PageResponse {
    get {return _pagination ?? Cosmos_Base_Query_V1beta1_PageResponse()}
    set {_pagination = newValue}
  }
  /// Returns true if `pagination` has been explicitly set.
  var hasPagination: Bool {return self._pagination != nil}
  /// Clears the value of `pagination`. Subsequent reads from it will return its default value.
  mutating func clearPagination() {self._pagination = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _pagination: Cosmos_Base_Query_V1beta1_PageResponse? = nil
}

/// GetLatestValidatorSetRequest is the request type for the Query/GetValidatorSetByHeight RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// pagination defines an pagination for the request.
  var pagination: Cosmos_Base_Query_V1beta1_PageRequest {
    get {return _pagination ?? Cosmos_Base_Query_V1beta1_PageRequest()}
    set {_pagination = newValue}
  }
  /// Returns true if `pagination` has been explicitly set.
  var hasPagination: Bool {return self._pagination != nil}
  /// Clears the value of `pagination`. Subsequent reads from it will return its default value.
  mutating func clearPagination() {self._pagination = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _pagination: Cosmos_Base_Query_V1beta1_PageRequest? = nil
}

/// GetLatestValidatorSetResponse is the response type for the Query/GetValidatorSetByHeight RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockHeight: Int64 = 0

  var validators: [Cosmos_Base_Tendermint_V1beta1_Validator] = []

  /// pagination defines an pagination for the response.
  var pagination: Cosmos_Base_Query_V1beta1_PageResponse {
    get {return _pagination ?? Cosmos_Base_Query_V1beta1_PageResponse()}
    set {_pagination = newValue}
  }
  /// Returns true if `pagination` has been explicitly set.
  var hasPagination: Bool {return self._pagination != nil}
  /// Clears the value of `pagination`. Subsequent reads from it will return its default value.
  mutating func clearPagination() {self._pagination = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _pagination: Cosmos_Base_Query_V1beta1_PageResponse? = nil
}

/// Validator is the type for the validator-set.
struct Cosmos_Base_Tendermint_V1beta1_Validator {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var address: String = String()

  var pubKey: Google_Protobuf2_Any {
    get {return _pubKey ?? Google_Protobuf2_Any()}
    set {_pubKey = newValue}
  }
  /// Returns true if `pubKey` has been explicitly set.
  var hasPubKey: Bool {return self._pubKey != nil}
  /// Clears the value of `pubKey`. Subsequent reads from it will return its default value.
  mutating func clearPubKey() {self._pubKey = nil}

  var votingPower: Int64 = 0

  var proposerPriority: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _pubKey: Google_Protobuf2_Any? = nil
}

/// GetBlockByHeightRequest is the request type for the Query/GetBlockByHeight RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var height: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GetBlockByHeightResponse is the response type for the Query/GetBlockByHeight RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockID: Tendermint_Types_BlockID {
    get {return _blockID ?? Tendermint_Types_BlockID()}
    set {_blockID = newValue}
  }
  /// Returns true if `blockID` has been explicitly set.
  var hasBlockID: Bool {return self._blockID != nil}
  /// Clears the value of `blockID`. Subsequent reads from it will return its default value.
  mutating func clearBlockID() {self._blockID = nil}

  var block: Tendermint_Types_Block {
    get {return _block ?? Tendermint_Types_Block()}
    set {_block = newValue}
  }
  /// Returns true if `block` has been explicitly set.
  var hasBlock: Bool {return self._block != nil}
  /// Clears the value of `block`. Subsequent reads from it will return its default value.
  mutating func clearBlock() {self._block = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _blockID: Tendermint_Types_BlockID? = nil
  fileprivate var _block: Tendermint_Types_Block? = nil
}

/// GetLatestBlockRequest is the request type for the Query/GetLatestBlock RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GetLatestBlockResponse is the response type for the Query/GetLatestBlock RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var blockID: Tendermint_Types_BlockID {
    get {return _blockID ?? Tendermint_Types_BlockID()}
    set {_blockID = newValue}
  }
  /// Returns true if `blockID` has been explicitly set.
  var hasBlockID: Bool {return self._blockID != nil}
  /// Clears the value of `blockID`. Subsequent reads from it will return its default value.
  mutating func clearBlockID() {self._blockID = nil}

  var block: Tendermint_Types_Block {
    get {return _block ?? Tendermint_Types_Block()}
    set {_block = newValue}
  }
  /// Returns true if `block` has been explicitly set.
  var hasBlock: Bool {return self._block != nil}
  /// Clears the value of `block`. Subsequent reads from it will return its default value.
  mutating func clearBlock() {self._block = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _blockID: Tendermint_Types_BlockID? = nil
  fileprivate var _block: Tendermint_Types_Block? = nil
}

/// GetSyncingRequest is the request type for the Query/GetSyncing RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GetSyncingResponse is the response type for the Query/GetSyncing RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var syncing: Bool = false

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GetNodeInfoRequest is the request type for the Query/GetNodeInfo RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GetNodeInfoResponse is the request type for the Query/GetNodeInfo RPC method.
struct Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var defaultNodeInfo: Tendermint_P2p_DefaultNodeInfo {
    get {return _defaultNodeInfo ?? Tendermint_P2p_DefaultNodeInfo()}
    set {_defaultNodeInfo = newValue}
  }
  /// Returns true if `defaultNodeInfo` has been explicitly set.
  var hasDefaultNodeInfo: Bool {return self._defaultNodeInfo != nil}
  /// Clears the value of `defaultNodeInfo`. Subsequent reads from it will return its default value.
  mutating func clearDefaultNodeInfo() {self._defaultNodeInfo = nil}

  var applicationVersion: Cosmos_Base_Tendermint_V1beta1_VersionInfo {
    get {return _applicationVersion ?? Cosmos_Base_Tendermint_V1beta1_VersionInfo()}
    set {_applicationVersion = newValue}
  }
  /// Returns true if `applicationVersion` has been explicitly set.
  var hasApplicationVersion: Bool {return self._applicationVersion != nil}
  /// Clears the value of `applicationVersion`. Subsequent reads from it will return its default value.
  mutating func clearApplicationVersion() {self._applicationVersion = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _defaultNodeInfo: Tendermint_P2p_DefaultNodeInfo? = nil
  fileprivate var _applicationVersion: Cosmos_Base_Tendermint_V1beta1_VersionInfo? = nil
}

/// VersionInfo is the type for the GetNodeInfoResponse message.
struct Cosmos_Base_Tendermint_V1beta1_VersionInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var appName: String = String()

  var version: String = String()

  var gitCommit: String = String()

  var buildTags: String = String()

  var goVersion: String = String()

  var buildDeps: [Cosmos_Base_Tendermint_V1beta1_Module] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// Module is the type for VersionInfo
struct Cosmos_Base_Tendermint_V1beta1_Module {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// module path
  var path: String = String()

  /// module version
  var version: String = String()

  /// checksum
  var sum: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "cosmos.base.tendermint.v1beta1"

extension Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetValidatorSetByHeightRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "height"),
    2: .same(proto: "pagination"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.height)
      case 2: try decoder.decodeSingularMessageField(value: &self._pagination)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.height != 0 {
      try visitor.visitSingularInt64Field(value: self.height, fieldNumber: 1)
    }
    if let v = self._pagination {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest, rhs: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightRequest) -> Bool {
    if lhs.height != rhs.height {return false}
    if lhs._pagination != rhs._pagination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetValidatorSetByHeightResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_height"),
    2: .same(proto: "validators"),
    3: .same(proto: "pagination"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.blockHeight)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.validators)
      case 3: try decoder.decodeSingularMessageField(value: &self._pagination)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.blockHeight != 0 {
      try visitor.visitSingularInt64Field(value: self.blockHeight, fieldNumber: 1)
    }
    if !self.validators.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.validators, fieldNumber: 2)
    }
    if let v = self._pagination {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse, rhs: Cosmos_Base_Tendermint_V1beta1_GetValidatorSetByHeightResponse) -> Bool {
    if lhs.blockHeight != rhs.blockHeight {return false}
    if lhs.validators != rhs.validators {return false}
    if lhs._pagination != rhs._pagination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetLatestValidatorSetRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "pagination"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._pagination)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._pagination {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest, rhs: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetRequest) -> Bool {
    if lhs._pagination != rhs._pagination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetLatestValidatorSetResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_height"),
    2: .same(proto: "validators"),
    3: .same(proto: "pagination"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.blockHeight)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.validators)
      case 3: try decoder.decodeSingularMessageField(value: &self._pagination)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.blockHeight != 0 {
      try visitor.visitSingularInt64Field(value: self.blockHeight, fieldNumber: 1)
    }
    if !self.validators.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.validators, fieldNumber: 2)
    }
    if let v = self._pagination {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse, rhs: Cosmos_Base_Tendermint_V1beta1_GetLatestValidatorSetResponse) -> Bool {
    if lhs.blockHeight != rhs.blockHeight {return false}
    if lhs.validators != rhs.validators {return false}
    if lhs._pagination != rhs._pagination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_Validator: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Validator"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "address"),
    2: .standard(proto: "pub_key"),
    3: .standard(proto: "voting_power"),
    4: .standard(proto: "proposer_priority"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.address)
      case 2: try decoder.decodeSingularMessageField(value: &self._pubKey)
      case 3: try decoder.decodeSingularInt64Field(value: &self.votingPower)
      case 4: try decoder.decodeSingularInt64Field(value: &self.proposerPriority)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.address.isEmpty {
      try visitor.visitSingularStringField(value: self.address, fieldNumber: 1)
    }
    if let v = self._pubKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    if self.votingPower != 0 {
      try visitor.visitSingularInt64Field(value: self.votingPower, fieldNumber: 3)
    }
    if self.proposerPriority != 0 {
      try visitor.visitSingularInt64Field(value: self.proposerPriority, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_Validator, rhs: Cosmos_Base_Tendermint_V1beta1_Validator) -> Bool {
    if lhs.address != rhs.address {return false}
    if lhs._pubKey != rhs._pubKey {return false}
    if lhs.votingPower != rhs.votingPower {return false}
    if lhs.proposerPriority != rhs.proposerPriority {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetBlockByHeightRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "height"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.height)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.height != 0 {
      try visitor.visitSingularInt64Field(value: self.height, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest, rhs: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightRequest) -> Bool {
    if lhs.height != rhs.height {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetBlockByHeightResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .same(proto: "block"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._blockID)
      case 2: try decoder.decodeSingularMessageField(value: &self._block)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._blockID {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._block {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse, rhs: Cosmos_Base_Tendermint_V1beta1_GetBlockByHeightResponse) -> Bool {
    if lhs._blockID != rhs._blockID {return false}
    if lhs._block != rhs._block {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetLatestBlockRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest, rhs: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockRequest) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetLatestBlockResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .same(proto: "block"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._blockID)
      case 2: try decoder.decodeSingularMessageField(value: &self._block)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._blockID {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._block {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse, rhs: Cosmos_Base_Tendermint_V1beta1_GetLatestBlockResponse) -> Bool {
    if lhs._blockID != rhs._blockID {return false}
    if lhs._block != rhs._block {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetSyncingRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest, rhs: Cosmos_Base_Tendermint_V1beta1_GetSyncingRequest) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetSyncingResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "syncing"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBoolField(value: &self.syncing)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.syncing != false {
      try visitor.visitSingularBoolField(value: self.syncing, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse, rhs: Cosmos_Base_Tendermint_V1beta1_GetSyncingResponse) -> Bool {
    if lhs.syncing != rhs.syncing {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetNodeInfoRequest"
  static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest, rhs: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoRequest) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetNodeInfoResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "default_node_info"),
    2: .standard(proto: "application_version"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._defaultNodeInfo)
      case 2: try decoder.decodeSingularMessageField(value: &self._applicationVersion)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._defaultNodeInfo {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._applicationVersion {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse, rhs: Cosmos_Base_Tendermint_V1beta1_GetNodeInfoResponse) -> Bool {
    if lhs._defaultNodeInfo != rhs._defaultNodeInfo {return false}
    if lhs._applicationVersion != rhs._applicationVersion {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_VersionInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".VersionInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .standard(proto: "app_name"),
    3: .same(proto: "version"),
    4: .standard(proto: "git_commit"),
    5: .standard(proto: "build_tags"),
    6: .standard(proto: "go_version"),
    7: .standard(proto: "build_deps"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.name)
      case 2: try decoder.decodeSingularStringField(value: &self.appName)
      case 3: try decoder.decodeSingularStringField(value: &self.version)
      case 4: try decoder.decodeSingularStringField(value: &self.gitCommit)
      case 5: try decoder.decodeSingularStringField(value: &self.buildTags)
      case 6: try decoder.decodeSingularStringField(value: &self.goVersion)
      case 7: try decoder.decodeRepeatedMessageField(value: &self.buildDeps)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.appName.isEmpty {
      try visitor.visitSingularStringField(value: self.appName, fieldNumber: 2)
    }
    if !self.version.isEmpty {
      try visitor.visitSingularStringField(value: self.version, fieldNumber: 3)
    }
    if !self.gitCommit.isEmpty {
      try visitor.visitSingularStringField(value: self.gitCommit, fieldNumber: 4)
    }
    if !self.buildTags.isEmpty {
      try visitor.visitSingularStringField(value: self.buildTags, fieldNumber: 5)
    }
    if !self.goVersion.isEmpty {
      try visitor.visitSingularStringField(value: self.goVersion, fieldNumber: 6)
    }
    if !self.buildDeps.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.buildDeps, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_VersionInfo, rhs: Cosmos_Base_Tendermint_V1beta1_VersionInfo) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.appName != rhs.appName {return false}
    if lhs.version != rhs.version {return false}
    if lhs.gitCommit != rhs.gitCommit {return false}
    if lhs.buildTags != rhs.buildTags {return false}
    if lhs.goVersion != rhs.goVersion {return false}
    if lhs.buildDeps != rhs.buildDeps {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Base_Tendermint_V1beta1_Module: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Module"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "path"),
    2: .same(proto: "version"),
    3: .same(proto: "sum"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.path)
      case 2: try decoder.decodeSingularStringField(value: &self.version)
      case 3: try decoder.decodeSingularStringField(value: &self.sum)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.path.isEmpty {
      try visitor.visitSingularStringField(value: self.path, fieldNumber: 1)
    }
    if !self.version.isEmpty {
      try visitor.visitSingularStringField(value: self.version, fieldNumber: 2)
    }
    if !self.sum.isEmpty {
      try visitor.visitSingularStringField(value: self.sum, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Base_Tendermint_V1beta1_Module, rhs: Cosmos_Base_Tendermint_V1beta1_Module) -> Bool {
    if lhs.path != rhs.path {return false}
    if lhs.version != rhs.version {return false}
    if lhs.sum != rhs.sum {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
