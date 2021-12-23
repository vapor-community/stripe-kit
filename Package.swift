// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "stripe-kit",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "StripeKit", targets: ["StripeKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.1.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"),
    ],
    targets: [
        .target(name: "StripeKit", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "Crypto", package: "swift-crypto"),
        ]),
        .testTarget(name: "StripeKitTests", dependencies: [
            .target(name: "StripeKit")
        ])
    ]
)
