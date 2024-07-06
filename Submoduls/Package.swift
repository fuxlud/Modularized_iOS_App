// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Submodules",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "DomainLayer", targets: ["DomainLayer"]),
        .library(name: "DataLayer", targets: ["DataLayer"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "PresentationLayer_DesignSystem", targets: ["PresentationLayer_DesignSystem"]),
        .library(name: "PresentationLayer_Features_AllBreeds", targets: ["PresentationLayer_Features_AllBreeds"]),
        .library(name: "PresentationLayer_Features_MainTabBar", targets: ["PresentationLayer_Features_MainTabBar"]),
        .library(name: "PresentationLayer_Features_DetailsScreen", targets: ["PresentationLayer_Features_DetailsScreen"]),
    ],
    targets: [
        .target(
            name: "DomainLayer",
            dependencies: []
        ),
        .testTarget(
            name: "DomainLayerTests",
            dependencies: ["DomainLayer"]
        ),
        .target(
            name: "Networking",
            dependencies: []
        ),
        .target(
            name: "DataLayer",
            dependencies: ["DomainLayer", "Networking"]
        ),
        .target(
            name: "PresentationLayer_DesignSystem",
            dependencies: []
        ),
        .target(
            name: "PresentationLayer_Features_AllBreeds",
            dependencies: ["DataLayer",
                           "DomainLayer",
                           "PresentationLayer_DesignSystem",
                           "PresentationLayer_Features_DetailsScreen"] //DetailsScreen should be moved to coordinator. Data moved to dependeci container
        ),
        .target(
            name: "PresentationLayer_Features_MainTabBar",
            dependencies: ["DataLayer",
                           "DomainLayer",
                           "PresentationLayer_DesignSystem",
                           "PresentationLayer_Features_DetailsScreen",
                           "PresentationLayer_Features_AllBreeds"] //DetailsScreen should be moved to coordinator. Data moved to dependeci container
        ),
        .target(
            name: "PresentationLayer_Features_DetailsScreen",
            dependencies: ["DomainLayer", "PresentationLayer_DesignSystem", "DataLayer"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
        .testTarget(
            name: "PresentationLayer_Features_AllBreedsTests",
            dependencies: ["DomainLayer", "PresentationLayer_Features_AllBreeds"]
        )
    ]
)
