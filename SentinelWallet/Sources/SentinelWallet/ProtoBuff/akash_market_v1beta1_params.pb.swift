// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: akash/market/v1beta1/params.proto
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

/// Params is the params for the x/market module
struct Akash_Market_V1beta1_Params {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var bidMinDeposit: Cosmos_Base_V1beta1_Coin {
    get {return _bidMinDeposit ?? Cosmos_Base_V1beta1_Coin()}
    set {_bidMinDeposit = newValue}
  }
  /// Returns true if `bidMinDeposit` has been explicitly set.
  var hasBidMinDeposit: Bool {return self._bidMinDeposit != nil}
  /// Clears the value of `bidMinDeposit`. Subsequent reads from it will return its default value.
  mutating func clearBidMinDeposit() {self._bidMinDeposit = nil}

  var orderMaxBids: UInt32 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _bidMinDeposit: Cosmos_Base_V1beta1_Coin? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "akash.market.v1beta1"

extension Akash_Market_V1beta1_Params: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Params"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "bid_min_deposit"),
    2: .standard(proto: "order_max_bids"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._bidMinDeposit)
      case 2: try decoder.decodeSingularUInt32Field(value: &self.orderMaxBids)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._bidMinDeposit {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if self.orderMaxBids != 0 {
      try visitor.visitSingularUInt32Field(value: self.orderMaxBids, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Akash_Market_V1beta1_Params, rhs: Akash_Market_V1beta1_Params) -> Bool {
    if lhs._bidMinDeposit != rhs._bidMinDeposit {return false}
    if lhs.orderMaxBids != rhs.orderMaxBids {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
