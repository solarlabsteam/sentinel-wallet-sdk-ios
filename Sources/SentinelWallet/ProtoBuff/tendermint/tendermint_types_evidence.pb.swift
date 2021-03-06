// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: tendermint/types/evidence.proto
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

struct Tendermint_Types_Evidence {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var sum: Tendermint_Types_Evidence.OneOf_Sum? = nil

  var duplicateVoteEvidence: Tendermint_Types_DuplicateVoteEvidence {
    get {
      if case .duplicateVoteEvidence(let v)? = sum {return v}
      return Tendermint_Types_DuplicateVoteEvidence()
    }
    set {sum = .duplicateVoteEvidence(newValue)}
  }

  var lightClientAttackEvidence: Tendermint_Types_LightClientAttackEvidence {
    get {
      if case .lightClientAttackEvidence(let v)? = sum {return v}
      return Tendermint_Types_LightClientAttackEvidence()
    }
    set {sum = .lightClientAttackEvidence(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum OneOf_Sum: Equatable {
    case duplicateVoteEvidence(Tendermint_Types_DuplicateVoteEvidence)
    case lightClientAttackEvidence(Tendermint_Types_LightClientAttackEvidence)

  #if !swift(>=4.1)
    static func ==(lhs: Tendermint_Types_Evidence.OneOf_Sum, rhs: Tendermint_Types_Evidence.OneOf_Sum) -> Bool {
      switch (lhs, rhs) {
      case (.duplicateVoteEvidence(let l), .duplicateVoteEvidence(let r)): return l == r
      case (.lightClientAttackEvidence(let l), .lightClientAttackEvidence(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  init() {}
}

/// DuplicateVoteEvidence contains evidence of a validator signed two conflicting votes.
struct Tendermint_Types_DuplicateVoteEvidence {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var voteA: Tendermint_Types_Vote {
    get {return _voteA ?? Tendermint_Types_Vote()}
    set {_voteA = newValue}
  }
  /// Returns true if `voteA` has been explicitly set.
  var hasVoteA: Bool {return self._voteA != nil}
  /// Clears the value of `voteA`. Subsequent reads from it will return its default value.
  mutating func clearVoteA() {self._voteA = nil}

  var voteB: Tendermint_Types_Vote {
    get {return _voteB ?? Tendermint_Types_Vote()}
    set {_voteB = newValue}
  }
  /// Returns true if `voteB` has been explicitly set.
  var hasVoteB: Bool {return self._voteB != nil}
  /// Clears the value of `voteB`. Subsequent reads from it will return its default value.
  mutating func clearVoteB() {self._voteB = nil}

  var totalVotingPower: Int64 = 0

  var validatorPower: Int64 = 0

  var timestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _timestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_timestamp = newValue}
  }
  /// Returns true if `timestamp` has been explicitly set.
  var hasTimestamp: Bool {return self._timestamp != nil}
  /// Clears the value of `timestamp`. Subsequent reads from it will return its default value.
  mutating func clearTimestamp() {self._timestamp = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _voteA: Tendermint_Types_Vote? = nil
  fileprivate var _voteB: Tendermint_Types_Vote? = nil
  fileprivate var _timestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

/// LightClientAttackEvidence contains evidence of a set of validators attempting to mislead a light client.
struct Tendermint_Types_LightClientAttackEvidence {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var conflictingBlock: Tendermint_Types_LightBlock {
    get {return _conflictingBlock ?? Tendermint_Types_LightBlock()}
    set {_conflictingBlock = newValue}
  }
  /// Returns true if `conflictingBlock` has been explicitly set.
  var hasConflictingBlock: Bool {return self._conflictingBlock != nil}
  /// Clears the value of `conflictingBlock`. Subsequent reads from it will return its default value.
  mutating func clearConflictingBlock() {self._conflictingBlock = nil}

  var commonHeight: Int64 = 0

  var byzantineValidators: [Tendermint_Types_Validator] = []

  var totalVotingPower: Int64 = 0

  var timestamp: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _timestamp ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_timestamp = newValue}
  }
  /// Returns true if `timestamp` has been explicitly set.
  var hasTimestamp: Bool {return self._timestamp != nil}
  /// Clears the value of `timestamp`. Subsequent reads from it will return its default value.
  mutating func clearTimestamp() {self._timestamp = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _conflictingBlock: Tendermint_Types_LightBlock? = nil
  fileprivate var _timestamp: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

struct Tendermint_Types_EvidenceList {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var evidence: [Tendermint_Types_Evidence] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "tendermint.types"

extension Tendermint_Types_Evidence: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Evidence"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "duplicate_vote_evidence"),
    2: .standard(proto: "light_client_attack_evidence"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1:
        var v: Tendermint_Types_DuplicateVoteEvidence?
        if let current = self.sum {
          try decoder.handleConflictingOneOf()
          if case .duplicateVoteEvidence(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.sum = .duplicateVoteEvidence(v)}
      case 2:
        var v: Tendermint_Types_LightClientAttackEvidence?
        if let current = self.sum {
          try decoder.handleConflictingOneOf()
          if case .lightClientAttackEvidence(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.sum = .lightClientAttackEvidence(v)}
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    switch self.sum {
    case .duplicateVoteEvidence(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    case .lightClientAttackEvidence(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tendermint_Types_Evidence, rhs: Tendermint_Types_Evidence) -> Bool {
    if lhs.sum != rhs.sum {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tendermint_Types_DuplicateVoteEvidence: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".DuplicateVoteEvidence"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "vote_a"),
    2: .standard(proto: "vote_b"),
    3: .standard(proto: "total_voting_power"),
    4: .standard(proto: "validator_power"),
    5: .same(proto: "timestamp"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._voteA)
      case 2: try decoder.decodeSingularMessageField(value: &self._voteB)
      case 3: try decoder.decodeSingularInt64Field(value: &self.totalVotingPower)
      case 4: try decoder.decodeSingularInt64Field(value: &self.validatorPower)
      case 5: try decoder.decodeSingularMessageField(value: &self._timestamp)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._voteA {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._voteB {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    if self.totalVotingPower != 0 {
      try visitor.visitSingularInt64Field(value: self.totalVotingPower, fieldNumber: 3)
    }
    if self.validatorPower != 0 {
      try visitor.visitSingularInt64Field(value: self.validatorPower, fieldNumber: 4)
    }
    if let v = self._timestamp {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tendermint_Types_DuplicateVoteEvidence, rhs: Tendermint_Types_DuplicateVoteEvidence) -> Bool {
    if lhs._voteA != rhs._voteA {return false}
    if lhs._voteB != rhs._voteB {return false}
    if lhs.totalVotingPower != rhs.totalVotingPower {return false}
    if lhs.validatorPower != rhs.validatorPower {return false}
    if lhs._timestamp != rhs._timestamp {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tendermint_Types_LightClientAttackEvidence: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".LightClientAttackEvidence"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "conflicting_block"),
    2: .standard(proto: "common_height"),
    3: .standard(proto: "byzantine_validators"),
    4: .standard(proto: "total_voting_power"),
    5: .same(proto: "timestamp"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._conflictingBlock)
      case 2: try decoder.decodeSingularInt64Field(value: &self.commonHeight)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.byzantineValidators)
      case 4: try decoder.decodeSingularInt64Field(value: &self.totalVotingPower)
      case 5: try decoder.decodeSingularMessageField(value: &self._timestamp)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._conflictingBlock {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if self.commonHeight != 0 {
      try visitor.visitSingularInt64Field(value: self.commonHeight, fieldNumber: 2)
    }
    if !self.byzantineValidators.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.byzantineValidators, fieldNumber: 3)
    }
    if self.totalVotingPower != 0 {
      try visitor.visitSingularInt64Field(value: self.totalVotingPower, fieldNumber: 4)
    }
    if let v = self._timestamp {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tendermint_Types_LightClientAttackEvidence, rhs: Tendermint_Types_LightClientAttackEvidence) -> Bool {
    if lhs._conflictingBlock != rhs._conflictingBlock {return false}
    if lhs.commonHeight != rhs.commonHeight {return false}
    if lhs.byzantineValidators != rhs.byzantineValidators {return false}
    if lhs.totalVotingPower != rhs.totalVotingPower {return false}
    if lhs._timestamp != rhs._timestamp {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Tendermint_Types_EvidenceList: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".EvidenceList"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "evidence"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.evidence)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.evidence.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.evidence, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Tendermint_Types_EvidenceList, rhs: Tendermint_Types_EvidenceList) -> Bool {
    if lhs.evidence != rhs.evidence {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
