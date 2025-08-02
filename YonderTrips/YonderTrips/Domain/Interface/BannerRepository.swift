//
//  BannerRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 8/2/25.
//

import Foundation

protocol BannerRepository {
    func fetchBanners() async throws -> [BannerItem]
}
