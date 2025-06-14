//
//  ActivityUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import Foundation

struct ActivityUseCase {
    
    func requestActivityList(
        country: ActivityCountry,
        catergory: ActivityCategory,
        id: String
    ) async throws -> ActivitySummaryList {
        
        let response: ActivitySummaryListResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .activity(.activities(country, catergory, id)))
        return response.toEntity()
    }
    
    func requestActivityDetail(with activityId: String) async throws -> Activity
    {
        let response: ActivityResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .activity(.detail(activityId)))
        return response.toEntity()
    }
}
