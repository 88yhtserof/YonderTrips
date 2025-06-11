//
//  AdvertisementBannerView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import SwiftUI

struct AdvertisementBannerContentView: UIViewControllerRepresentable {
    
    let bannerList: [String]
    
    func makeUIViewController(context: Context) -> AdvertisementBannerViewController {
        return AdvertisementBannerViewController(list: bannerList)
    }
    
    func updateUIViewController(_ uiViewController: AdvertisementBannerViewController, context: Context) {
        uiViewController.updateList(with: bannerList)
    }
}

struct AdvertisementBannerView: View {
    
    let list: [String] = [
      ]
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            AdvertisementBannerContentView(bannerList: list)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
            
            PageIndicatorView(currentIndex: Int.random(in: 1...100), totalCount: list.count)
                .padding(.bottom, 12)
                .padding(.trailing, 8)
        }
    }
}

#Preview {
    AdvertisementBannerView()
}
