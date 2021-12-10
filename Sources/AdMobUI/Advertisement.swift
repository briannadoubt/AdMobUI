//
//  Advertisement.swift
//  AdMobUI
//
//  Created by Brianna Zamora on 9/19/21.
//

import Foundation

public protocol Advertisement {
    var unitId: String { get }
    var style: AdvertisementStyle { get }
}

public enum AdvertisementStyle {
    case inline
    case anchored
}
