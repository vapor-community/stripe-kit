// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "StripeKit",
    products: [
        .library(name: "StripeKit", targets: ["StripeKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "StripeKit", dependencies: ["AsyncHTTPClient", "NIOFoundationCompat"]),
        .testTarget(name: "StripeKitTests", dependencies: ["AsyncHTTPClient", "StripeKit"])
    ]
)
