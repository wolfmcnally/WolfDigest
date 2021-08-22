// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "WolfDigest",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "WolfDigest",
            targets: ["WolfDigest"]),
    ],
    dependencies: [
        .package(name: "WolfBase", url: "https://github.com/WolfMcNally/WolfBase", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "WolfDigest",
            dependencies: ["WolfBase"]),
        .testTarget(
            name: "WolfDigestTests",
            dependencies: ["WolfDigest"]),
    ]
)
