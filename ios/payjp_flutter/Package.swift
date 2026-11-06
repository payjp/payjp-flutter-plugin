// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "payjp_flutter",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "payjp-flutter", targets: ["payjp_flutter"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        // sdkconfig.json の ios と同じバージョンに合わせること (tool/check_sdk_version.sh で検証)
        .package(url: "https://github.com/payjp/payjp-ios.git", .upToNextMinor(from: "2.2.4")),
        .package(url: "https://github.com/google/GoogleUtilities.git", from: "8.0.0"),
    ],
    targets: [
        .target(
            name: "payjp_flutter",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "PAYJP", package: "payjp-ios"),
                .product(name: "GULAppDelegateSwizzler", package: "GoogleUtilities"),
            ]
        )
    ]
)
