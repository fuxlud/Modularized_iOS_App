// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Submodules",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DomainMock", targets: ["DomainMock"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "SearchScreen", targets: ["SearchScreen"])
    ],
    targets: [
        .target(name: "DomainMock"),
        .target(name: "Domain"),
        .target(name: "SearchScreen")
    ]
)
