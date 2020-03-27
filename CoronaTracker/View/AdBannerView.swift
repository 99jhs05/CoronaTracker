//
//  AdBannerView.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-25.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMobileAds

final class AdBannerView: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        
        let adSize = GADAdSizeFromCGSize(CGSize(width: UIScreen.main.bounds.width, height:60))
        
        let view = GADBannerView(adSize: adSize)
        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-1597948650859519/1606908485" //"ca-app-pub-3940256099942544/6300978111"
        view.rootViewController = viewController
        view.delegate = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: adSize.size)
        view.load(GADRequest())
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension UIViewController: GADBannerViewDelegate {
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
    }

    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
       print(error)
    }
}

