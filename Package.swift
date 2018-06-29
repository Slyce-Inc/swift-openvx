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
    .package(url: "git@githb.com:ilmco/Clibcuda.git", .upToNextMinor(from: "9.0.0")),
    .package(url: "git@githb.com:ilmco/Clibvisionworks.git", .branch("master")),
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
