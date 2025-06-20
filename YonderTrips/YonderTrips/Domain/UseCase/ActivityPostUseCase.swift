//
//  ActivityPostUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/5/25.
//

import Foundation

struct ActivityPostUseCase {
    
    func requestActivityPost(country: String? = nil,
                             category: String? = nil,
                             longitude: Double? = nil,
                             latitude: Double? = nil,
                             maxDistance: Double? = nil,
                             next: String = "",
                             order_by: YTActivityPostAPI.OrderBy = .createdAt)
    async throws -> PostSummaryPagination
    {
        let response: PostSummaryPaginationResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .activityPost(
            .geolocation(country: country,
                         category: category,
                         longitude: longitude,
                         latitude: latitude,
                         maxDistance: maxDistance,
                         next: next,
                         order_by: order_by)
        ))
        return response.toEntity()
    }
}
