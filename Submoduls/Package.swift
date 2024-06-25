// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Submodules",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "DomainMock", targets: ["DomainMock"]),
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Data", targets: ["Data"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "RecipesList_Previews", targets: ["RecipesList_Previews"]),
        .library(name: "RecipesScreen", targets: ["RecipesScreen"])
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
            dependencies: ["DomainMock", "DesignSystem"]
        ),
        .target(
            name: "RecipesScreen",
            dependencies: ["Domain", "DesignSystem"]
        )
    ]
)
