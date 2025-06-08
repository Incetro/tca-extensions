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
    dependencies: [
        .package(
            url: "https://github.com/Incetro/tca-network-reducers.git",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "tca-extensions",
            dependencies: [
                .product(name: "TCANetworkReducers", package: "tca-network-reducers")
            ]
        ),
        .testTarget(
            name: "tca-extensionsTests",
            dependencies: ["tca-extensions"]
        ),
    ]
)
