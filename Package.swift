// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SentinelWallet",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SentinelWallet",
            targets: ["SentinelWallet"]
        ),
    ],
    dependencies: [
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.0")),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", .upToNextMajor(from: "1.9.0")),
        .package(url: "https://github.com/lika-vorobeva/HDWallet", .branch("spm"))
    ],
    targets: [
        .target(
            name: "SentinelWallet",
            dependencies: [
                "SwiftProtobuf", "HDWallet", "Alamofire", "SwiftyBeaver",
                .product(name: "GRPC", package: "grpc-swift"),
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ]
        ),
        .testTarget(
            name: "SentinelWalletTests",
            dependencies: ["SentinelWallet"]),
    ]
)
