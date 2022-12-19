// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "Crypto",
  platforms: [
    .macOS(.v11),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v9),
    .driverKit(.v22),
    .macCatalyst(.v13)
  ],
  products: [
    .library(
      name: "Crypto",
      targets: ["Crypto"]
    )
  ],
  targets: [
    .target(name: "Crypto"),
    .testTarget(name: "CryptoTests", dependencies: ["Crypto"]),
    .testTarget(name: "TestsPerformance", dependencies: ["Crypto"])
  ]
)
