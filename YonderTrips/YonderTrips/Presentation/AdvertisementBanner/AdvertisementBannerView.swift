//
//  AdvertisementBannerView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import SwiftUI

// MARK: - AdvertisementBannerContentView
struct AdvertisementBannerContentView: UIViewControllerRepresentable {
    
    let bannerList: [BannerItem]
    @Binding var currentIndex: Int
    let onBannerTap: (BannerItem) -> Void
    
    func makeUIViewController(context: Context) -> AdvertisementBannerViewController {
        return AdvertisementBannerViewController(list: bannerList.map { $0.imageUrl }) { index in
            currentIndex = index + 1
        }
    }
    
    func updateUIViewController(_ uiViewController: AdvertisementBannerViewController, context: Context) {
        uiViewController.updateList(with: bannerList.map { $0.imageUrl })
        
        uiViewController.setBannerTapHandler { index in
            if index < bannerList.count {
                onBannerTap(bannerList[index])
            }
        }
    }
}

// MARK: - AdvertisementBannerView
struct AdvertisementBannerView: View {
    
    @StateObject var viewModel: AdvertisementBannerViewModel
    @State private var currentIndex: Int = 1
    @State private var selectedBannerURL: WebViewURL? = nil
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            if viewModel.state.isLoading {
                // 로딩 상태
                Rectangle()
                    .fill(Color.gray30)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        ProgressView()
                            .tint(.white)
                    )
            } else if viewModel.state.bannerList.isEmpty {
                // 빈 배너 상태
                Rectangle()
                    .fill(Color.gray30)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("배너가 없습니다")
                            .foregroundColor(.gray)
                            .font(.caption)
                    )
            } else {
                AdvertisementBannerContentView(
                    bannerList: viewModel.state.bannerList,
                    currentIndex: $currentIndex,
                    onBannerTap: handleBannerTap
                )
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(.gray30)
                
                PageIndicatorView(currentIndex: currentIndex, totalCount: viewModel.state.bannerList.count)
                    .padding(.bottom, 12)
                    .padding(.trailing, 8)
            }
        }
        .onAppear {
            viewModel.action(.onAppear)
        }
        .sheet(item: $selectedBannerURL) { item in
            WebViewModalView(url: item.url)
        }
        .alert("오류", isPresented: .constant(viewModel.state.error != nil)) {
            Button("확인") {
                viewModel.state.error = nil
            }
        } message: {
            if let error = viewModel.state.error {
                Text(error)
            }
        }
    }
    
    private func handleBannerTap(_ banner: BannerItem) {
        viewModel.action(.bannerTapped(banner))
        
        if banner.payload.type == "WEBVIEW" {
            selectedBannerURL = WebViewURL(url: banner.payload.value)
        }
    }
}

//MARK: - Type
extension AdvertisementBannerView {
    
    struct WebViewURL: Identifiable {
        var id: String { url }
        let url: String
    }

}
