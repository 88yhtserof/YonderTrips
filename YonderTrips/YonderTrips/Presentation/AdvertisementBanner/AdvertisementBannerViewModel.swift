//
//  AdvertisementBannerViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/29/25.
//

import SwiftUI
import WebKit

@MainActor
class AdvertisementBannerViewModel: ObservableObject {
    
    @Published var state = State()
    
    private let bannerRepository: BannerRepository
    
    struct State {
        var bannerList: [BannerItem] = []
        var isLoading: Bool = false
        var error: String? = nil
    }
    
    init(bannerService: BannerRepository = LiveBannerRepository(), accessToken: String = "") {
        self.bannerRepository = bannerService
    }
}

//MARK: - Action
extension AdvertisementBannerViewModel {
    
    enum Action {
        case onAppear
        case loadBanners
        case bannerTapped(BannerItem)
    }
    
    func action(_ action: Action) {
        switch action {
        case .onAppear:
            loadBannersIfNeeded()
            
        case .loadBanners:
            loadBanners()
            
        case .bannerTapped(let banner):
            handleBannerTap(banner)
        }
    }
}

//MARK: - Function
private extension AdvertisementBannerViewModel {
    
    private func loadBannersIfNeeded() {
        guard state.bannerList.isEmpty && !state.isLoading else { return }
        loadBanners()
    }
    
    private func loadBanners() {
        state.isLoading = true
        state.error = nil
        
        Task {
            do {
                let banners = try await bannerRepository.fetchBanners()
                state.bannerList = banners
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.isLoading = false
            }
        }
    }
    
    private func handleBannerTap(_ banner: BannerItem) {
        print("Banner tapped: \(banner.name)")
    }
}
