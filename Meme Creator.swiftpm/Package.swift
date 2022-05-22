// swift-tools-version: 5.5

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Meme Creator",
    platforms: [
        .iOS("15.2")
    ],
    products: [ 
        .iOSApplication(
            name: "Meme Creator",
            targets: ["App"],
            displayVersion: "1.0",
            bundleVersion: "1",
            iconAssetName: "AppIcon",
            supportedDeviceFamilies: [
                .pad, .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [

            ]
        )
    ],
    targets: [
        .executableTarget(name: "App", path: "App")
    ]
)

