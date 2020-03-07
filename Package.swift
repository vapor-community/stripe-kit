// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "StripeKit",
    products: [
        .library(name: "StripeKit", targets: ["StripeKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", .exact("1.1.0")),
    ],
    targets: [
        .target(name: "StripeKit", dependencies: ["AsyncHTTPClient"]),
        .testTarget(name: "StripeKitTests", dependencies: ["AsyncHTTPClient", "StripeKit"])
    ]
)
