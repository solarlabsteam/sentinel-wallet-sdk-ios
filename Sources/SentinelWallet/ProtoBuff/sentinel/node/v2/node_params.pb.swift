// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/node/v2/params.proto
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

struct Sentinel_Node_V2_Params {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var deposit: Cosmos_Base_V1beta1_Coin {
    get {return _deposit ?? Cosmos_Base_V1beta1_Coin()}
    set {_deposit = newValue}
  }
  /// Returns true if `deposit` has been explicitly set.
  var hasDeposit: Bool {return self._deposit != nil}
  /// Clears the value of `deposit`. Subsequent reads from it will return its default value.
  mutating func clearDeposit() {self._deposit = nil}

  var activeDuration: SwiftProtobuf.Google_Protobuf_Duration {
    get {return _activeDuration ?? SwiftProtobuf.Google_Protobuf_Duration()}
    set {_activeDuration = newValue}
  }
  /// Returns true if `activeDuration` has been explicitly set.
  var hasActiveDuration: Bool {return self._activeDuration != nil}
  /// Clears the value of `activeDuration`. Subsequent reads from it will return its default value.
  mutating func clearActiveDuration() {self._activeDuration = nil}

  var maxGigabytePrices: [Cosmos_Base_V1beta1_Coin] = []

  var minGigabytePrices: [Cosmos_Base_V1beta1_Coin] = []

  var maxHourlyPrices: [Cosmos_Base_V1beta1_Coin] = []

  var minHourlyPrices: [Cosmos_Base_V1beta1_Coin] = []

  var maxSubscriptionGigabytes: Int64 = 0

  var minSubscriptionGigabytes: Int64 = 0

  var maxSubscriptionHours: Int64 = 0

  var minSubscriptionHours: Int64 = 0

  var stakingShare: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _deposit: Cosmos_Base_V1beta1_Coin? = nil
  fileprivate var _activeDuration: SwiftProtobuf.Google_Protobuf_Duration? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Sentinel_Node_V2_Params: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "sentinel.node.v2"

extension Sentinel_Node_V2_Params: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Params"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "deposit"),
    2: .standard(proto: "active_duration"),
    3: .standard(proto: "max_gigabyte_prices"),
    4: .standard(proto: "min_gigabyte_prices"),
    5: .standard(proto: "max_hourly_prices"),
    6: .standard(proto: "min_hourly_prices"),
    7: .standard(proto: "max_subscription_gigabytes"),
    8: .standard(proto: "min_subscription_gigabytes"),
    9: .standard(proto: "max_subscription_hours"),
    10: .standard(proto: "min_subscription_hours"),
    11: .standard(proto: "staking_share"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._deposit) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._activeDuration) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.maxGigabytePrices) }()
      case 4: try { try decoder.decodeRepeatedMessageField(value: &self.minGigabytePrices) }()
      case 5: try { try decoder.decodeRepeatedMessageField(value: &self.maxHourlyPrices) }()
      case 6: try { try decoder.decodeRepeatedMessageField(value: &self.minHourlyPrices) }()
      case 7: try { try decoder.decodeSingularInt64Field(value: &self.maxSubscriptionGigabytes) }()
      case 8: try { try decoder.decodeSingularInt64Field(value: &self.minSubscriptionGigabytes) }()
      case 9: try { try decoder.decodeSingularInt64Field(value: &self.maxSubscriptionHours) }()
      case 10: try { try decoder.decodeSingularInt64Field(value: &self.minSubscriptionHours) }()
      case 11: try { try decoder.decodeSingularStringField(value: &self.stakingShare) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._deposit {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._activeDuration {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if !self.maxGigabytePrices.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.maxGigabytePrices, fieldNumber: 3)
    }
    if !self.minGigabytePrices.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.minGigabytePrices, fieldNumber: 4)
    }
    if !self.maxHourlyPrices.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.maxHourlyPrices, fieldNumber: 5)
    }
    if !self.minHourlyPrices.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.minHourlyPrices, fieldNumber: 6)
    }
    if self.maxSubscriptionGigabytes != 0 {
      try visitor.visitSingularInt64Field(value: self.maxSubscriptionGigabytes, fieldNumber: 7)
    }
    if self.minSubscriptionGigabytes != 0 {
      try visitor.visitSingularInt64Field(value: self.minSubscriptionGigabytes, fieldNumber: 8)
    }
    if self.maxSubscriptionHours != 0 {
      try visitor.visitSingularInt64Field(value: self.maxSubscriptionHours, fieldNumber: 9)
    }
    if self.minSubscriptionHours != 0 {
      try visitor.visitSingularInt64Field(value: self.minSubscriptionHours, fieldNumber: 10)
    }
    if !self.stakingShare.isEmpty {
      try visitor.visitSingularStringField(value: self.stakingShare, fieldNumber: 11)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Sentinel_Node_V2_Params, rhs: Sentinel_Node_V2_Params) -> Bool {
    if lhs._deposit != rhs._deposit {return false}
    if lhs._activeDuration != rhs._activeDuration {return false}
    if lhs.maxGigabytePrices != rhs.maxGigabytePrices {return false}
    if lhs.minGigabytePrices != rhs.minGigabytePrices {return false}
    if lhs.maxHourlyPrices != rhs.maxHourlyPrices {return false}
    if lhs.minHourlyPrices != rhs.minHourlyPrices {return false}
    if lhs.maxSubscriptionGigabytes != rhs.maxSubscriptionGigabytes {return false}
    if lhs.minSubscriptionGigabytes != rhs.minSubscriptionGigabytes {return false}
    if lhs.maxSubscriptionHours != rhs.maxSubscriptionHours {return false}
    if lhs.minSubscriptionHours != rhs.minSubscriptionHours {return false}
    if lhs.stakingShare != rhs.stakingShare {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
