// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Submodules",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "RecipesList", targets: ["RecipesList"]),
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: []
        ),
        .testTarget(
            name: "DomainTests",
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
            name: "RecipesList",
            dependencies: ["Domain", "DesignSystem"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
        .testTarget(
            name: "RecipesListTests",
            dependencies: ["Domain", "RecipesList"]
        )
    ]
)
