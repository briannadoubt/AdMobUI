//
//  AnchoredAd.swift
//  AdMobUI
//
//  Created by Brianna Zamora on 9/15/21.
//

import GoogleMobileAds
import SwiftUI
import UIKit
import KeyWindow
import AppTrackingTransparency

public struct AnchoredAd: View {
    
    @AppStorage("showingAds") private var showingAds: Bool = true
    
    let ad: Advertisement
    
    @State public var height: CGFloat = 320
    @State public var width: CGFloat = 320
    
    func update(size: CGSize) {
        self.height = size.height
        self.width = size.width
    }
    
    public var body: some View {
        Group {
            if showingAds {
                AnchoredAdRepresentable(ad: ad)
                    .frame(width: width, height: height)
                    .onAppear {
                        setFrame()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                        setFrame()
                    }
                    .listRowInsets(EdgeInsets())
            }
        }
    }
    
    func setFrame() {
        let adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(keyWindowSafeAreaFrame.width)
        self.width = adSize.size.width
        self.height = adSize.size.height
    }
}

struct AnchoredAdRepresentable: UIViewControllerRepresentable {
    
    let ad: Advertisement
    
    func makeUIViewController(context: Context) -> UIViewController {
        return AnchoredAdViewController(ad: ad)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}


class AnchoredAdViewController: UIViewController {
    
    let ad: Advertisement
    var bannerView = GADBannerView()
    var request: GADRequest?
    
    init(ad: Advertisement) {
        self.ad = ad
        self.request = GADRequest()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .clear
        bannerView.adUnitID = ad.unitId
        bannerView.rootViewController = self
        view.addSubview(bannerView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBannerAd()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.bannerView.isHidden = true
        } completion: { _ in
            self.bannerView.isHidden = false
            self.loadBannerAd()
        }
    }

    func loadBannerAd() {
        let frame = view.frame.inset(by: view.safeAreaInsets)
        let viewWidth = frame.size.width
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        let request = GADRequest()
        bannerView.load(request)
    }
}

struct AnchoredAd_Previews: PreviewProvider {
    static var previews: some View {
        AnchoredAd(ad: PreviewAd.anchoredPreview)
    }
}
