// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "StripeKit",
    products: [
        .library(name: "StripeKit", targets: ["StripeKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/swift-nio-http-client.git", from: "0.0.0")
    ],
    targets: [
        .target(name: "StripeKit", dependencies: ["NIOHTTPClient", "NIOFoundationCompat"]),
        .testTarget(name: "StripeKitTests", dependencies: ["NIOHTTPClient", "StripeKit"])
    ]
)
