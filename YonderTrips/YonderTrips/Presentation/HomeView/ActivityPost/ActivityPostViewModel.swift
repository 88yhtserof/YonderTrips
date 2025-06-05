//
//  ActivityPostViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/5/25.
//

import Foundation

final class ActivityPostViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let activityPostUseCase: ActivityPostUseCase
    
    init(activityPostUseCase: ActivityPostUseCase) {
        self.activityPostUseCase = activityPostUseCase
    }
    
    struct State {
        var postSummaryList: [PostSummary] = []
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension ActivityPostViewModel {
    
    enum Action {
        case onAppear
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                do {
                    let pagination: PostSummaryPagination = try await activityPostUseCase.requestActivityPost(country: nil, category: nil, longitude: nil, latitude: nil, maxDistance: nil)
                    
                    state.postSummaryList = pagination.data
                } catch {
                    YonderTripsLogger.shared.debug("Falied to fetch activity post: \(error)")
                }
            }
        }
    }
}
