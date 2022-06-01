// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ExampleMVVMDependencies", platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Common",
            targets: ["Common"]),
		.library(
			name: "MoviesModule",
			targets: ["MoviesModule"]),
    ],
    dependencies: [
		.package(name: "Persistence", path: "../../Persistence")
	],
    targets: [
        .target(
            name: "Common",
            dependencies: []),
		.target(
			name: "MoviesModule",
			dependencies: ["Common", "Persistence"]),
    ]
)
