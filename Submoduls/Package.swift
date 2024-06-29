// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Submodules",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DomainMock", targets: ["DomainMock"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "DomainTests", targets: ["DomainTests"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "NetworkingTests", targets: ["NetworkingTests"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "RecipesList_Previews", targets: ["RecipesList_Previews"]),
        .library(name: "RecipesList", targets: ["RecipesList"])
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: []
        ),
        .target(
            name: "DomainMock",
            dependencies: ["Domain"]
        ),
        .target(
            name: "Networking",
            dependencies: []
        ),
        .target(
            name: "Data",
            dependencies: ["Domain", "Networking"]
        ),
        .target(
            name: "DesignSystem",
            dependencies: []
        ),
        .target(
            name: "RecipesList_Previews",
            dependencies: ["DomainMock", "DesignSystem", "RecipesList"]
        ),
        .target(
            name: "RecipesList",
            dependencies: ["Domain", "DesignSystem"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: ["Domain", "DomainMock"]
        )
    ]
)
