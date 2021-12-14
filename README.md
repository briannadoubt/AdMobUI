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

## Installation

AdMobUI only support iOS since the `GoogleMobileAdsSDK` doesn't support any other operating system.

AdMobUI also pulls `GoogleMobileAdsSDK` through an unofficial swift package in order to avoid using `cocoapods`. There are known issues when archiving your product. More info here: https://github.com/quanghits/GoogleMobileAds

### Discussion

If you want to use Swift Package Manager, you can't use mediation groups that support third party SDKs with this library. If you need to incorporate ad partner SDKs, you must use the Cocoapods installation and follow Google's recommended installation via their official documentation.

### Swift Package Manager

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

### Cocoapods

Add this repo and Google Mobile Ads to your Podfile and run `pod install` per usual.
```
pod 'GoogleMobileAdsSDK'
pod 'AdMobUI'
```

## Info.plist Configuration

Depending on you ad sources in your mediation groups you'll need to incorporate additional SKAdNetworkIdentifiers in your info.plist. But, if you are only utilizing AdMob incorporated mediation group partners (either using Cocoapods _without_ third party SDKs, or using SPM), the following plist file will suffice. Check your app's logs for missing SKAdNetworkIdentifiers and add them as needed.

```xml
<key>GADApplicationIdentifier</key>
<string>YOUR APP ID</string>
<key>SKAdNetworkItems</key>
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cstr6suwn9.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4fzdc2evr5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2fnua5tdw4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ydx93a7ass.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>5a6flpkh64.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>p78axxw29g.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v72qych5uu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>c6k4g5qg8m.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>s39g8k73mm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qy4746246.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3sh42y64q3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>f38h382jlk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>hs6bdukanm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>prcb7njmu6.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>v4nxqhlyqp.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>wzmmz9fp6w.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>yclnxrl5pm.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>t38b2kh725.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>7ug5zh24hu.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9rd848q2bz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>n6fk4nfna4.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>kbd757ywx3.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>9t245vhmpl.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4468km3ulz.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>2u9pt9hc89.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8s468mfl3y.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>av6w8kgt66.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>klf5c3l5u5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>ppxm28t8ap.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>424m5254lk.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>uw77j35x4d.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>578prtvx9j.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>4dzt52r2t5.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>e5fvkxwrpn.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>8c4e2ghe7u.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>zq492l623r.skadnetwork</string>
    </dict>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>3qcr597p9d.skadnetwork</string>
    </dict>
</array>
```
