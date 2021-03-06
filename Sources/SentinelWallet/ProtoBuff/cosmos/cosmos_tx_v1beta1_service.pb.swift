// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: cosmos/tx/v1beta1/service.proto
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

/// BroadcastMode specifies the broadcast mode for the TxService.Broadcast RPC method.
enum Cosmos_Tx_V1beta1_BroadcastMode: SwiftProtobuf.Enum {
  typealias RawValue = Int

  /// zero-value for mode ordering
  case unspecified // = 0

  /// BROADCAST_MODE_BLOCK defines a tx broadcasting mode where the client waits for
  /// the tx to be committed in a block.
  case block // = 1

  /// BROADCAST_MODE_SYNC defines a tx broadcasting mode where the client waits for
  /// a CheckTx execution response only.
  case sync // = 2

  /// BROADCAST_MODE_ASYNC defines a tx broadcasting mode where the client returns
  /// immediately.
  case async // = 3
  case UNRECOGNIZED(Int)

  init() {
    self = .unspecified
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .unspecified
    case 1: self = .block
    case 2: self = .sync
    case 3: self = .async
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .unspecified: return 0
    case .block: return 1
    case .sync: return 2
    case .async: return 3
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Cosmos_Tx_V1beta1_BroadcastMode: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Cosmos_Tx_V1beta1_BroadcastMode] = [
    .unspecified,
    .block,
    .sync,
    .async,
  ]
}

#endif  // swift(>=4.2)

/// GetTxsEventRequest is the request type for the Service.TxsByEvents
/// RPC method.
struct Cosmos_Tx_V1beta1_GetTxsEventRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// events is the list of transaction event type.
  var events: [String] = []

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

/// GetTxsEventResponse is the response type for the Service.TxsByEvents
/// RPC method.
struct Cosmos_Tx_V1beta1_GetTxsEventResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// txs is the list of queried transactions.
  var txs: [Cosmos_Tx_V1beta1_Tx] = []

  /// tx_responses is the list of queried TxResponses.
  var txResponses: [Cosmos_Base_Abci_V1beta1_TxResponse] = []

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

/// BroadcastTxRequest is the request type for the Service.BroadcastTxRequest
/// RPC method.
struct Cosmos_Tx_V1beta1_BroadcastTxRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// tx_bytes is the raw transaction.
  var txBytes: Data = SwiftProtobuf.Internal.emptyData

  var mode: Cosmos_Tx_V1beta1_BroadcastMode = .unspecified

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// BroadcastTxResponse is the response type for the
/// Service.BroadcastTx method.
struct Cosmos_Tx_V1beta1_BroadcastTxResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// tx_response is the queried TxResponses.
  var txResponse: Cosmos_Base_Abci_V1beta1_TxResponse {
    get {return _txResponse ?? Cosmos_Base_Abci_V1beta1_TxResponse()}
    set {_txResponse = newValue}
  }
  /// Returns true if `txResponse` has been explicitly set.
  var hasTxResponse: Bool {return self._txResponse != nil}
  /// Clears the value of `txResponse`. Subsequent reads from it will return its default value.
  mutating func clearTxResponse() {self._txResponse = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _txResponse: Cosmos_Base_Abci_V1beta1_TxResponse? = nil
}

/// SimulateRequest is the request type for the Service.Simulate
/// RPC method.
struct Cosmos_Tx_V1beta1_SimulateRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// tx is the transaction to simulate.
  var tx: Cosmos_Tx_V1beta1_Tx {
    get {return _tx ?? Cosmos_Tx_V1beta1_Tx()}
    set {_tx = newValue}
  }
  /// Returns true if `tx` has been explicitly set.
  var hasTx: Bool {return self._tx != nil}
  /// Clears the value of `tx`. Subsequent reads from it will return its default value.
  mutating func clearTx() {self._tx = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _tx: Cosmos_Tx_V1beta1_Tx? = nil
}

/// SimulateResponse is the response type for the
/// Service.SimulateRPC method.
struct Cosmos_Tx_V1beta1_SimulateResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// gas_info is the information about gas used in the simulation.
  var gasInfo: Cosmos_Base_Abci_V1beta1_GasInfo {
    get {return _gasInfo ?? Cosmos_Base_Abci_V1beta1_GasInfo()}
    set {_gasInfo = newValue}
  }
  /// Returns true if `gasInfo` has been explicitly set.
  var hasGasInfo: Bool {return self._gasInfo != nil}
  /// Clears the value of `gasInfo`. Subsequent reads from it will return its default value.
  mutating func clearGasInfo() {self._gasInfo = nil}

  /// result is the result of the simulation.
  var result: Cosmos_Base_Abci_V1beta1_Result {
    get {return _result ?? Cosmos_Base_Abci_V1beta1_Result()}
    set {_result = newValue}
  }
  /// Returns true if `result` has been explicitly set.
  var hasResult: Bool {return self._result != nil}
  /// Clears the value of `result`. Subsequent reads from it will return its default value.
  mutating func clearResult() {self._result = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _gasInfo: Cosmos_Base_Abci_V1beta1_GasInfo? = nil
  fileprivate var _result: Cosmos_Base_Abci_V1beta1_Result? = nil
}

/// GetTxRequest is the request type for the Service.GetTx
/// RPC method.
struct Cosmos_Tx_V1beta1_GetTxRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// hash is the tx hash to query, encoded as a hex string.
  var hash: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// GetTxResponse is the response type for the Service.GetTx method.
struct Cosmos_Tx_V1beta1_GetTxResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// tx is the queried transaction.
  var tx: Cosmos_Tx_V1beta1_Tx {
    get {return _tx ?? Cosmos_Tx_V1beta1_Tx()}
    set {_tx = newValue}
  }
  /// Returns true if `tx` has been explicitly set.
  var hasTx: Bool {return self._tx != nil}
  /// Clears the value of `tx`. Subsequent reads from it will return its default value.
  mutating func clearTx() {self._tx = nil}

  /// tx_response is the queried TxResponses.
  var txResponse: Cosmos_Base_Abci_V1beta1_TxResponse {
    get {return _txResponse ?? Cosmos_Base_Abci_V1beta1_TxResponse()}
    set {_txResponse = newValue}
  }
  /// Returns true if `txResponse` has been explicitly set.
  var hasTxResponse: Bool {return self._txResponse != nil}
  /// Clears the value of `txResponse`. Subsequent reads from it will return its default value.
  mutating func clearTxResponse() {self._txResponse = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _tx: Cosmos_Tx_V1beta1_Tx? = nil
  fileprivate var _txResponse: Cosmos_Base_Abci_V1beta1_TxResponse? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "cosmos.tx.v1beta1"

extension Cosmos_Tx_V1beta1_BroadcastMode: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "BROADCAST_MODE_UNSPECIFIED"),
    1: .same(proto: "BROADCAST_MODE_BLOCK"),
    2: .same(proto: "BROADCAST_MODE_SYNC"),
    3: .same(proto: "BROADCAST_MODE_ASYNC"),
  ]
}

extension Cosmos_Tx_V1beta1_GetTxsEventRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetTxsEventRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "events"),
    2: .same(proto: "pagination"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedStringField(value: &self.events)
      case 2: try decoder.decodeSingularMessageField(value: &self._pagination)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.events.isEmpty {
      try visitor.visitRepeatedStringField(value: self.events, fieldNumber: 1)
    }
    if let v = self._pagination {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_GetTxsEventRequest, rhs: Cosmos_Tx_V1beta1_GetTxsEventRequest) -> Bool {
    if lhs.events != rhs.events {return false}
    if lhs._pagination != rhs._pagination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_GetTxsEventResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetTxsEventResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "txs"),
    2: .standard(proto: "tx_responses"),
    3: .same(proto: "pagination"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.txs)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.txResponses)
      case 3: try decoder.decodeSingularMessageField(value: &self._pagination)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.txs.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.txs, fieldNumber: 1)
    }
    if !self.txResponses.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.txResponses, fieldNumber: 2)
    }
    if let v = self._pagination {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_GetTxsEventResponse, rhs: Cosmos_Tx_V1beta1_GetTxsEventResponse) -> Bool {
    if lhs.txs != rhs.txs {return false}
    if lhs.txResponses != rhs.txResponses {return false}
    if lhs._pagination != rhs._pagination {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_BroadcastTxRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".BroadcastTxRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "tx_bytes"),
    2: .same(proto: "mode"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.txBytes)
      case 2: try decoder.decodeSingularEnumField(value: &self.mode)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.txBytes.isEmpty {
      try visitor.visitSingularBytesField(value: self.txBytes, fieldNumber: 1)
    }
    if self.mode != .unspecified {
      try visitor.visitSingularEnumField(value: self.mode, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_BroadcastTxRequest, rhs: Cosmos_Tx_V1beta1_BroadcastTxRequest) -> Bool {
    if lhs.txBytes != rhs.txBytes {return false}
    if lhs.mode != rhs.mode {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_BroadcastTxResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".BroadcastTxResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "tx_response"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._txResponse)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._txResponse {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_BroadcastTxResponse, rhs: Cosmos_Tx_V1beta1_BroadcastTxResponse) -> Bool {
    if lhs._txResponse != rhs._txResponse {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_SimulateRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SimulateRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "tx"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._tx)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._tx {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_SimulateRequest, rhs: Cosmos_Tx_V1beta1_SimulateRequest) -> Bool {
    if lhs._tx != rhs._tx {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_SimulateResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".SimulateResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "gas_info"),
    2: .same(proto: "result"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._gasInfo)
      case 2: try decoder.decodeSingularMessageField(value: &self._result)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._gasInfo {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._result {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_SimulateResponse, rhs: Cosmos_Tx_V1beta1_SimulateResponse) -> Bool {
    if lhs._gasInfo != rhs._gasInfo {return false}
    if lhs._result != rhs._result {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_GetTxRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetTxRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "hash"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self.hash)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.hash.isEmpty {
      try visitor.visitSingularStringField(value: self.hash, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_GetTxRequest, rhs: Cosmos_Tx_V1beta1_GetTxRequest) -> Bool {
    if lhs.hash != rhs.hash {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Cosmos_Tx_V1beta1_GetTxResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GetTxResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "tx"),
    2: .standard(proto: "tx_response"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._tx)
      case 2: try decoder.decodeSingularMessageField(value: &self._txResponse)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._tx {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._txResponse {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Cosmos_Tx_V1beta1_GetTxResponse, rhs: Cosmos_Tx_V1beta1_GetTxResponse) -> Bool {
    if lhs._tx != rhs._tx {return false}
    if lhs._txResponse != rhs._txResponse {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
