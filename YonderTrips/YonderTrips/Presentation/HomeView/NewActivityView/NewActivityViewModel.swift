//
//  NewActivityViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

final class NewActivityViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let newActivityUseCase: NewActivityUseCase
    
    init(newActivityUseCase: NewActivityUseCase) {
        self.newActivityUseCase = newActivityUseCase
        
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
extension NewActivityViewModel {
    
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
                    state.activitySummaryList = try await newActivityUseCase.requestNewActivityList()
                    
                    let activityList: [Activity] = await withTaskGroup(of: Activity?.self) { group in
                        for summary in state.activitySummaryList {
                            group.addTask { [weak self] in
                                guard let self else { return nil }
                                
                                do {
                                    // TODO: - 액세스 토큰 갱신 이후에도 토큰이 만료되었다고 에러 발생
                                    return try await self.newActivityUseCase.requestNewActivityDetail(with: summary.activityId)
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
                    print("회원 인증 시간 만료 alert 띄우기")
                }
            }
        }
    }
}
