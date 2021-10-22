# AdMobUI

A simple AdMob ads wrapper for SwiftUI

## Usage

First, create a struct that conforms to the `Advertisement` protocol:

```swift
enum DemoAd: String, Advertisement {
    
    case anchored
    case inline
    
    var unitId: String {
        switch self {
        case .anchored, .inline:
            return "ca-app-pub-3940256099942544/2934735716"
        }
    }
    
    var style: AdvertisementStyle {
        switch self {
        case .anchored:
            return .anchored
        case .inline:
            return .inline
        }
    }
}
```

Then, pass that in to an `InlineAd` or `AnchoredAd` view:

```swift
struct ContentView: View {
    var body: some View {
        TabView {
            VStack {
                Spacer()
                AnchoredAd(ad: DemoAd.anchored)
            }
            .tabItem {
                Label("Anchored", systemImage: "circle.fill")
            }
            
            List {
                InlineAd(ad: DemoAd.inline)
            }
        }
    }
}
``` 

## Discussion

AdMobUI only support iOS since the `GoogleMobileAdsSDK` doesn't support any other operating system.

AdMobUI also pulls `GoogleMobileAdsSDK` through an unofficial swift package in order to avoid using `cocoapods`. There are known issues when archiving your product. More info here:  

## Installation

Search for https://github.com/briannadoubt/AdMobUI in `Xcode -> File -> Add Packages...` or add the following to the dependancies your `Package.swift` file:

```swift
// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "MySwiftPackage",
    packages: [
        .package(
            name: "KeyWindow",
            url: "https://github.com/briannadoubt/KeyWindow.git",
            .upToNextMajor(from: "0.1.0")
        )
    ],
    targets: [
        .target(
            name: "MySwiftPackage",
            dependencies: [
                .product(
                    name: "KeyWindow",
                    package: "KeyWindow"
                )
            ]
        ),
        .testTarget(
            name: "MySwiftPackageTests",
            dependencies: ["MySwiftPackage"]
        )
    ]
)
```
