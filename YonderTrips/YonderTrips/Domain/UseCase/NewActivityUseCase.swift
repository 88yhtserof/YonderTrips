//
//  NewActivityUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/29/25.
//

import Foundation

struct NewActivityUseCase {
    
    func requestNewActivityList(country: ActivityCountry = .none,
                                catergory: ActivityCategory = .none) async throws -> [ActivitySummary]
    {
        
        let response: ListResponseDTO<ActivitySummaryResponseDTO> = try await NetworkService.requestWithAuth(apiConfiguration: YonderTripsActivityAPI.new(.none, .none))
        return response.data.map { $0.toEntity() }

    }
    
    func requestNewActivityDetail(with activityId: String) async throws -> Activity
    {
        let response: ActivityResponseDTO = try await NetworkService.requestWithAuth(apiConfiguration: YonderTripsActivityAPI.detail(activityId))
        return response.toEntity()
    }
}
