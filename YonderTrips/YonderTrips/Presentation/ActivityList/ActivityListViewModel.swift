//
//  ActivityListViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import Foundation

final class ActivityListViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let activityUseCase: ActivityUseCase
    let category: ActivityCategory
    let country: ActivityCountry
    
    private var nextCursorId: String = ""
    
    init(activityUseCase: ActivityUseCase, category: ActivityCategory, country: ActivityCountry) {
        self.activityUseCase = activityUseCase
        self.category = category
        self.country = country
        
        binding()
    }
    
    struct State {
        var activitySummaryList = Array<ActivitySummary>()
        var activityList = Array<Activity>()
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension ActivityListViewModel {
    
    enum Action {
        case onAppear
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .onAppear:
            
            guard state.activitySummaryList.isEmpty else { return }
            
            Task {
                do {
                    let response = try await activityUseCase.requestActivityList(country: country, catergory: category, id: nextCursorId)
                    state.activitySummaryList = response.data
                    nextCursorId = response.nextCursor
                    
                    let activityList: [Activity] = await withTaskGroup(of: Activity?.self) { group in
                        for summary in state.activitySummaryList {
                            group.addTask { [weak self] in
                                guard let self else { return nil }
                                
                                do {
                                    return try await self.activityUseCase.requestActivityDetail(with: summary.activityId)
                                } catch {
                                    YonderTripsLogger.shared.debug("Failed to fetch activity detail")
                                    return nil
                                }
                            }
                        }
                        
                        var results: [Activity] = []
                        for await activity  in group {
                            if let activity {
                                results.append(activity)
                            }
                        }
                        return results
                    }
                    
                    state.activityList = activityList
                    
                } catch let error as AuthNetworkError where error == .refreshTokenExpired {
                    YonderTripsLogger.shared.debug("Refresh token expired")
                }
            }
        }
    }
}

