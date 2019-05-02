// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Stripe",
    products: [
        .library(name: "Stripe", targets: ["Stripe"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/swift-server/swift-nio-http-client.git", .branch("master"))
    ],
    targets: [
        .target(name: "Stripe", dependencies: ["NIOHTTPClient", "NIOFoundationCompat"]),
        .testTarget(name: "StripeTests", dependencies: ["NIOHTTPClient", "Stripe"])
    ]
)
