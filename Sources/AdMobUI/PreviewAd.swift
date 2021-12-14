//
//  PreviewAd.swift
//  AdModUI
//
//  Created by Brianna Zamora on 9/16/21.
//

import Foundation

#if canImport(GoogleMobileAds)
enum PreviewAd: Advertisement {
    
    case inlinePreview
    case anchoredPreview
    
    var unitId: String {
        switch self {
        case .inlinePreview:
            return "ca-app-pub-3940256099942544/2934735716"
        case .anchoredPreview:
            return "ca-app-pub-3940256099942544/2934735716"
        }
    }
    
    var style: AdvertisementStyle {
        switch self {
        case .inlinePreview:
            return .inline
        case .anchoredPreview:
            return .anchored
        }
    }
}
#endif
