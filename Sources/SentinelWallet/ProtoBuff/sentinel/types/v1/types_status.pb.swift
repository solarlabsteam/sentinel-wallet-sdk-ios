// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: sentinel/types/v1/status.proto
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

public enum Sentinel_Types_V1_Status: SwiftProtobuf.Enum {
    public typealias RawValue = Int
    case unspecified // = 0
    case active // = 1
    case inactivePending // = 2
    case inactive // = 3
    case UNRECOGNIZED(Int)
    
    public init() {
        self = .unspecified
    }
    
    public init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .unspecified
        case 1: self = .active
        case 2: self = .inactivePending
        case 3: self = .inactive
        default: self = .UNRECOGNIZED(rawValue)
        }
    }
    
    public var rawValue: Int {
        switch self {
        case .unspecified: return 0
        case .active: return 1
        case .inactivePending: return 2
        case .inactive: return 3
        case .UNRECOGNIZED(let i): return i
        }
    }
    
}

#if swift(>=4.2)

extension Sentinel_Types_V1_Status: CaseIterable {
    // The compiler won't synthesize support with the UNRECOGNIZED case.
    public static var allCases: [Sentinel_Types_V1_Status] = [
        .unspecified,
        .active,
        .inactivePending,
        .inactive,
    ]
}

#endif  // swift(>=4.2)

#if swift(>=5.5) && canImport(_Concurrency)
extension Sentinel_Types_V1_Status: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Sentinel_Types_V1_Status: SwiftProtobuf._ProtoNameProviding {
    public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
        0: .same(proto: "STATUS_UNSPECIFIED"),
        1: .same(proto: "STATUS_ACTIVE"),
        2: .same(proto: "STATUS_INACTIVE_PENDING"),
        3: .same(proto: "STATUS_INACTIVE"),
    ]
}
