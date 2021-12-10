//
//  AdMobUI.swift
//  
//
//  Created by Bri on 10/23/21.
//

@_exported import GoogleMobileAds

public struct AdMobUI {
    public static func startGoogleMobileAds(
        testIdentifiers: [String]? = nil,
        maxAdContentRating: GADMaxAdContentRating = .general,
        completion: GADInitializationCompletionHandler? = nil
    ) {
        #if DEBUG
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = testIdentifiers
        #endif
        GADMobileAds.sharedInstance().requestConfiguration.maxAdContentRating = maxAdContentRating
        GADMobileAds.sharedInstance().start(completionHandler: completion)
    }
}
