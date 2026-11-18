// swift-tools-version:6.0
import PackageDescription

/// Settings for every target
let swiftSettings: [SwiftSetting] = [
    // Existential types are spelled `any P`, so they can't be mistaken for generics
    .enableUpcomingFeature("ExistentialAny"),
]

let package = Package(
    name: "stripe-kit",
    platforms: [
        .macOS(.v14),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(name: "StripeKit", targets: ["StripeKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.33.1"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.97.1"),
        .package(url: "https://github.com/apple/swift-crypto.git", "3.0.0" ..< "6.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.4.0"),
    ],
    targets: [
        .target(name: "StripeKit", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "Crypto", package: "swift-crypto"),
            .product(name: "NIO", package: "swift-nio"),
            .product(name: "NIOHTTP1", package: "swift-nio"),
        ], swiftSettings: swiftSettings + [
            // Each file must import the modules whose members it uses, so the Foundation
            // imports stay accurate
            .enableUpcomingFeature("MemberImportVisibility"),
        ]),
        .executableTarget(
            name: "stripe-kit-codegen",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources/Codegen",
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "StripeKitTests",
            dependencies: [
                .target(name: "StripeKit"),
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)
