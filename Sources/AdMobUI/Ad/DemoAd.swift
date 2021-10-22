//
//  File.swift
//  
//
//  Created by Bri on 10/22/21.
//

import Foundation

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
