// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tca-extensions",
    platforms: [
      .iOS(.v13)
      ],
    products: [
        .library(
            name: "tca-extensions",
            targets: ["tca-extensions"]),
    ],
    targets: [
        .target(
            name: "tca-extensions"),
        .testTarget(
            name: "tca-extensionsTests",
            dependencies: ["tca-extensions"]
        ),
    ]
)
