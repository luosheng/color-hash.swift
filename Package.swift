// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "ColorHash",
  platforms: [
    .iOS("8.0"),
    .macOS("10.9"),
    .watchOS("2.0"),
    .tvOS("9.0"),
  ],
  products: [
    .library(
      name: "ColorHash",
      targets: ["ColorHash"]
    )
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ColorHash",
      dependencies: [],
      path: "ColorHash"
    )
  ]
)
