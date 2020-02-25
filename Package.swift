// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Snazzy",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "Snazzy", targets: ["Snazzy"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Snazzy", dependencies: []),
    ]
)
