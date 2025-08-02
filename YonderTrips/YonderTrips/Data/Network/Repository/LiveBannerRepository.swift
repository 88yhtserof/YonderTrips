//
//  LiveBannerRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/29/25.
//

import Foundation

final class LiveBannerRepository: BannerRepository {
    
    func fetchBanners() async throws -> [BannerItem] {
        
        let response: BannerListResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .banner(.getBanners))
        
        return response.data.map{ $0.toEntity() }
    }
}
