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
    .package(url: "git@github.com:ilmco/Clibcuda.git", .branch("master")),
    .package(url: "git@github.com:ilmco/Clibvisionworks.git", .branch("master")),
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
