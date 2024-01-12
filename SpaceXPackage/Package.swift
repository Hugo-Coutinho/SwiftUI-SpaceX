// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpaceXPackage",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "UIComponent",
            targets: ["UIComponent"]),
        .library(
            name: "Launch",
            targets: ["Launch"])
    ],
    dependencies: [
        .package(url: "https://github.com/kean/NukeUI", from: "0.8.3"),
        .package(url: "https://github.com/Hugo-Coutinho/Network-Layer-Framework", from: "1.0.4")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: []),
        .target(
            name: "Network",
            dependencies: []),
        .target(
            name: "UIComponent",
            dependencies: [
                "Core"
            ]),
        .target(
            name: "Launch",
            dependencies: [
                "NukeUI",
                "UIComponent",
                "Network",
                .product(name: "HGNetworkLayer", package: "Network-Layer-Framework")
            ]),
        .testTarget(name: "CoreTests", dependencies: ["Core"])
    ]
)
