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
    private let activityUseCase: ActivityUseCase
    private var onError: ((String) -> Void)?
    
    init(
        newActivityUseCase: NewActivityUseCase,
        activityUseCase: ActivityUseCase,
        onError: ((String) -> Void)? = nil
    ) {
        self.newActivityUseCase = newActivityUseCase
        self.activityUseCase = activityUseCase
        self.onError = onError
        
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
                    onError?("사용자 인증이 만료되었습니다.\n다시 로그인 해주세요.")
                }
            }
        }
    }
}
