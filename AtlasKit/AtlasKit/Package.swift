// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AtlasKit",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "AtlasUI",
            targets: ["AtlasUI"]
        ),
        .library(
            name: "AtlasNetwork",
            targets: ["AtlasNetwork"]
        ),
        .library(
            name: "AtlasCore",
            targets: ["AtlasCore"]
        ),
    ],
    targets: [
        .target(
            name: "AtlasCore"
        ),
        .target(
            name: "AtlasNetwork",
            dependencies: ["AtlasCore"]
        ),
        .target(
            name: "AtlasUI",
            dependencies: ["AtlasCore"]
        ),
        .testTarget(
            name: "AtlasCoreTests",
            dependencies: ["AtlasCore"]
        ),
        .testTarget(
            name: "AtlasNetworkTests",
            dependencies: ["AtlasNetwork"]
        ),
        .testTarget(
            name: "AtlasUITests",
            dependencies: ["AtlasUI"]
        ),
    ]
)
