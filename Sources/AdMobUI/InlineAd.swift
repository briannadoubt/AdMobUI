//
//  InlineAd.swift
//  AdMobUI
//
//  Created by Brianna Zamora on 9/20/21.
//

import SwiftUI
#if canImport(GoogleMobileAds)
import GoogleMobileAds
#endif

#if canImport(GoogleMobileAds)
public struct InlineAd: View {
    
    @AppStorage("showingAds") private var showingAds: Bool = true
    
    private let ad: Advertisement
    
    @State private var height: CGFloat = 44
    
    public init(ad: Advertisement) {
        self.ad = ad
    }
    
    public var body: some View {
        if showingAds {
            GeometryReader { geometry in
                let adHeight = geometry.size.width * 0.61803398875
                InlineAdRepresentable(
                    ad: ad,
                    size: CGSize(width: geometry.size.width, height: adHeight)
                )
                .frame(width: geometry.size.width, height: adHeight)
                .cornerRadius(10)
                .onAppear {
                    self.height = adHeight
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .frame(height: height)
        }
    }
}

struct InlineAdRepresentable: UIViewControllerRepresentable {
    
    let ad: Advertisement
    var size: CGSize
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = InlineAdViewController(ad: ad, size: size)
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

class InlineAdViewController: UIViewController {
    
    let ad: Advertisement
    var bannerView: GADBannerView?
    let request = GADRequest()
    var size: CGSize
    
    init(ad: Advertisement, size: CGSize) {
        self.ad = ad
        self.size = size
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = .clear
        let adSize = GADAdSizeFromCGSize(size)
        let bannerView = GADBannerView(adSize: adSize)
        bannerView.delegate = self
        bannerView.adUnitID = ad.unitId
        bannerView.rootViewController = self
        bannerView.clipsToBounds = true
        
        self.bannerView = bannerView
        
        loadBannerAd()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(loadBannerAd), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
        if let bannerView = self.bannerView {
            view.addSubview(bannerView)
            bannerView.load(request)
        }
    }
}

extension InlineAdViewController: GADBannerViewDelegate {
    
    public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        if
            let responseInfo = bannerView.responseInfo,
            let responseIdentifier = responseInfo.responseIdentifier,
            let adNetworkClassName = responseInfo.adNetworkClassName
        {
            print("adViewDidReceiveAd from network: \(adNetworkClassName), response Id='\(responseIdentifier)'")
        }
    }
    
    public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        let errorDomain = error._domain
        let errorCode = error._code
        let errorMessage = error.localizedDescription
        let responseInfo = (error as NSError).userInfo[GADErrorUserInfoKeyResponseInfo] as? GADResponseInfo
        let underlyingError = (error as NSError).userInfo[NSUnderlyingErrorKey] as? Error
        if let responseInfo = responseInfo {
            print("Received error with domain: \(errorDomain), code: \(errorCode),"
              + "message: \(errorMessage), responseInfo: \(responseInfo),"
              + "underLyingError: \(underlyingError?.localizedDescription ?? "nil")")
        }
    }
}

struct InlineAd_Previews: PreviewProvider {
    static var previews: some View {
        InlineAd(ad: PreviewAd.inlinePreview)
    }
}
#endif
