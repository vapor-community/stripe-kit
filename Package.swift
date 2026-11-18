// swift-tools-version:6.0
import PackageDescription

/// Settings for every target
let swiftSettings: [SwiftSetting] = [
    // Existential types are spelled `any P`, so they can't be mistaken for generics
    .enableUpcomingFeature("ExistentialAny"),
]

/// Settings for the library targets
let librarySettings = swiftSettings + [
    // Each file must import the modules whose members it uses, so the imports stay accurate
    .enableUpcomingFeature("MemberImportVisibility"),
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
        // StripeKit is split so no module is too big to optimize in one compiler process (see
        // `GeneratedModule` in the codegen). Users import StripeKit, which re-exports the rest.
        .target(name: "StripeKit", dependencies: [
            .target(name: "StripeKitCore"),
            .target(name: "StripeKitModels"),
            .target(name: "StripeKitParams"),
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "NIO", package: "swift-nio"),
            .product(name: "NIOHTTP1", package: "swift-nio"),
        ], swiftSettings: librarySettings),
        // Generated resources, their inline types, and events, with errors and webhooks
        .target(name: "StripeKitModels", dependencies: [
            .target(name: "StripeKitCore"),
            .product(name: "Crypto", package: "swift-crypto"),
        ], swiftSettings: librarySettings),
        // Generated request params
        .target(name: "StripeKitParams", dependencies: [
            .target(name: "StripeKitCore"),
        ], swiftSettings: librarySettings),
        // Hand-written building blocks the generated code uses
        .target(name: "StripeKitCore", swiftSettings: librarySettings),
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
