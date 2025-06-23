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
    private var isRequesting: Bool = false
    
    init(activityUseCase: ActivityUseCase, category: ActivityCategory, country: ActivityCountry) {
        self.activityUseCase = activityUseCase
        self.category = category
        self.country = country
        
        binding()
    }
    
    struct State {
        var activitySummaryList: [ActivitySummary] = []
        var activityList: [Activity] = []
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension ActivityListViewModel {
    
    enum Action {
        case onAppear
        case pagination
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .onAppear:
            guard !isRequesting,
                  state.activitySummaryList.isEmpty else { return }
            requestActivityList()
            
        case .pagination:
            
            guard nextCursorId != "0",
                  !isRequesting else { return }
            requestActivityList()
        }
    }
    
    @MainActor
    func requestActivityList() {
        
        isRequesting = true
        
        Task {
            defer { isRequesting = false }
            
            do {
                let response = try await activityUseCase.requestActivityList(country: country, catergory: category, id: nextCursorId)
                state.activitySummaryList.append(contentsOf: response.data)
                nextCursorId = response.nextCursor
                
                let activityList: [Activity] = await withTaskGroup(of: Activity?.self) { group in
                    for summary in response.data {
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
                
                state.activityList.append(contentsOf: activityList)
                
            } catch let error as AuthNetworkError where error == .refreshTokenExpired {
                YonderTripsLogger.shared.debug("Refresh token expired")
            }
        }

    }
}

