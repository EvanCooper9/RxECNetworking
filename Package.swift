// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxECNetworking",
    products: [
        .library(
            name: "RxECNetworking",
            targets: ["RxECNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/EvanCooper9/ECNetworking", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        .target(
            name: "RxECNetworking",
            dependencies: ["ECNetworking", "RxSwift"],
            path: "Sources"),
        .testTarget(
            name: "RxECNetworkingTests",
            dependencies: ["RxECNetworking"],
            path: "Tests"),
    ]
)
