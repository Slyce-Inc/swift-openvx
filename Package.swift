// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "OpenVX",
  products: [
    .library(name: "OpenVX", targets: ["OpenVX"]),
    .library(name: "Clibvisionworks", targets: ["Clibvisionworks"])
  ],
  dependencies: [
    .package(url: "https://github.com/Slyce-Inc/swift-cuda.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "OpenVX",
      dependencies: ["Clibvisionworks", "Clibcudart"]
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
