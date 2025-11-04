// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SentinelWallet",
    platforms: [
        .iOS(.v15), .macOS(.v12)
    ],
    products: [
        .library(
            name: "SentinelWallet",
            targets: ["SentinelWallet"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.19.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/lika-vorobeva/HDWallet", .branch("swift-6"))
    ],
    targets: [
        .target(
            name: "SentinelWallet",
            dependencies: [
                "HDWallet", "SwiftyBeaver",
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "GRPC", package: "grpc-swift"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ]
        )
    ]
)
