// swift-tools-version:5.1
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
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "StripeKit", dependencies: ["AsyncHTTPClient", "Crypto"]),
        .testTarget(name: "StripeKitTests", dependencies: ["AsyncHTTPClient", "StripeKit"])
    ]
)
