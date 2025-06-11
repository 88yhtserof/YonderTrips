//
//  AdvertisementBannerView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import SwiftUI

struct AdvertisementBannerContentView: UIViewControllerRepresentable {
    
    let bannerList: [String]
    @Binding var currentIndex: Int
    
    func makeUIViewController(context: Context) -> AdvertisementBannerViewController {
        return AdvertisementBannerViewController(list: bannerList) { index in
            currentIndex = index + 1
        }
    }
    
    func updateUIViewController(_ uiViewController: AdvertisementBannerViewController, context: Context) {
        uiViewController.updateList(with: bannerList)
    }
}

struct AdvertisementBannerView: View {
    
    let list: [String] = [
      ]
    @State var currentIndex: Int = 1
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            AdvertisementBannerContentView(bannerList: list, currentIndex: $currentIndex)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(.gray30)
            
            PageIndicatorView(currentIndex: currentIndex, totalCount: list.count)
                .padding(.bottom, 12)
                .padding(.trailing, 8)
        }
    }
}

#Preview {
    AdvertisementBannerView()
}
