// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ExampleMVVMDependencies",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "Common",
			targets: ["Common"]),
		.library(
			name: "MoviesModule",
			targets: ["MoviesModule"]),
		.library(
			name: "Persistence",
			targets: ["Persistence"]),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "Common",
			dependencies: []),
		.target(
			name: "Persistence",
			dependencies: []),
		.target(
			name: "MoviesModule",
			dependencies: ["Common", "Persistence"]),
	]
)
