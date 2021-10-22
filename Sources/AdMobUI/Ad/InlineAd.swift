//
//  InlineAd.swift
//  Taro
//
//  Created by Brianna Zamora on 9/20/21.
//

import SwiftUI
import GoogleMobileAds

struct InlineAd: View {
    @AppStorage("showingAds") var showingAds: Bool = true
    
    let ad: Advertisement
    
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    @State var maxHeight: CGFloat
    
    public var body: some View {
        Group {
            if showingAds {
                InlineAdRepresentable(ad: ad, width: $width, maxHeight: $maxHeight, update: update(size:))
                    .frame(width: width, height: height)
                    .cornerRadius(10)
            }
        }
    }
    
    func update(size: CGSize) {
        withAnimation(.spring()) {
            self.width = size.width
            self.height = size.height
        }
    }
}

struct InlineAdRepresentable: UIViewControllerRepresentable {
    
    let ad: Advertisement
    
    @Binding var width: CGFloat
    @Binding var maxHeight: CGFloat
    
    var update: (_ size: CGSize) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {
        return InlineAdViewController(ad: ad, width: width, maxHeight: maxHeight, update: update)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

class InlineAdViewController: UIViewController {
    
    let ad: Advertisement
    var bannerView: GAMBannerView?
    var width: CGFloat
    var maxHeight: CGFloat
    var update: (_ size: CGSize) -> ()
    
    init(ad: Advertisement, width: CGFloat, maxHeight: CGFloat, update: @escaping (_ size: CGSize) -> ()) {
        self.ad = ad
        self.width = width
        self.maxHeight = maxHeight
        self.update = update
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .clear
        bannerView = GAMBannerView(adSize: GADInlineAdaptiveBannerAdSizeWithWidthAndMaxHeight(width + 2, maxHeight + 2))
        bannerView?.frame.origin.x -= 1
        bannerView?.frame.origin.y -= 1
        bannerView?.delegate = self
        bannerView?.adUnitID = ad.unitId
        bannerView?.validAdSizes = [NSValueFromGADAdSize(GADAdSizeBanner)]
        bannerView?.rootViewController = self
        bannerView?.clipsToBounds = true
        if let bannerView = bannerView {
            view.addSubview(bannerView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(loadBannerAd), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBannerAd()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.bannerView?.isHidden = true
        } completion: { _ in
            self.bannerView?.isHidden = false
            self.loadBannerAd()
        }
    }

    @objc
    func loadBannerAd() {
        bannerView?.load(GAMRequest())
    }
}

extension InlineAdViewController: GADBannerViewDelegate {
    public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        update(bannerView.adSize.size)
    }
    public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print("Failed ad", error)
    }
}

struct InlineAd_Previews: PreviewProvider {
    static var previews: some View {
        InlineAd(ad: DemoAd.inline, width: .constant(320), height: .constant(320), maxHeight: 320)
    }
}
