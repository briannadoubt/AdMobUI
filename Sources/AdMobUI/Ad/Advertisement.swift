//
//  Advertisement.swift
//  Advertisement
//
//  Created by Brianna Zamora on 9/19/21.
//

import Foundation

protocol Advertisement {
    var unitId: String { get }
    var style: AdvertisementStyle { get }
}

enum AdvertisementStyle {
    case inline
    case anchored
}
