// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "OpenVX",
  products: [
    .library(
      name: "OpenVX",
      targets: ["OpenVX"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/theia-ai/Clibcuda.git", .upToNextMinor(from: "9.0.0")),
    .package(url: "https://github.com/theia-ai/Clibvisionworks.git", .branch("master")),
  ],
  targets: [
    .target(
      name: "OpenVX",
      dependencies: ["Clibvisionworks", "Clibcuda"]
    ),
    .testTarget(
      name: "OpenVXTests",
      dependencies: ["OpenVX"]
    ),
  ]
)
