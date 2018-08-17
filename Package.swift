// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "OpenVX",
  products: [
    .library(name: "OpenVX", targets: ["OpenVX"]),
    .library(name: "Clibvisionworks", targets: ["Clibvisionworks"])
  ],
  dependencies: [
    .package(url: "git@github.com:ilmco/Clibcuda.git", .branch("master"))
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
    .target(
      name: "Clibvisionworks",
      dependencies: []
    ),
  ]
)
