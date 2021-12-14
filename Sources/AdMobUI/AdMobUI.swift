//
//  AdMobUI.swift
//  
//
//  Created by Bri on 10/23/21.
//

import SwiftUI

@_exported import AppTrackingTransparency

#if canImport(FirebaseCrashlytics)
import FirebaseCrashlytics
#endif

#if canImport(GoogleMobileAds)
import GoogleMobileAds

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
    
    @available(iOS 15.0.0, macOS 12.0.0, watchOS 8.0.0, tvOS 15.0.0, *)
    public static func requestTrackingAuthorization(_ complete: ((_ status: ATTrackingManager.AuthorizationStatus) -> ())? = nil) async {
        
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        switch status {
        case .authorized:
            complete?(status)
        case .notDetermined:
            complete?(status)
            #if canImport(FirebaseCrashlytics)
            Crashlytics.crashlytics().log("ATTrackingManager.requestTrackingAuthorization status: Not Determined")
            #endif
        case .denied:
            complete?(status)
            #if canImport(FirebaseCrashlytics)
            Crashlytics.crashlytics().log("ATTrackingManager.requestTrackingAuthorization status: Denied")
            #endif
        case .restricted:
            complete?(status)
            #if canImport(FirebaseCrashlytics)
            Crashlytics.crashlytics().log("ATTrackingManager.requestTrackingAuthorization status: Restricted")
            #endif
        @unknown default:
            complete?(status)
            #if canImport(FirebaseCrashlytics)
            Crashlytics.crashlytics().log("ATTrackingManager.requestTrackingAuthorization status: Unknown")
            #endif
        }
    }
}
#endif
