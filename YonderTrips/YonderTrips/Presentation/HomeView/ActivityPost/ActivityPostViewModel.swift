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
    private var onError: ((String) -> Void)?
    
    init(activityPostUseCase: ActivityPostUseCase) {
        self.activityPostUseCase = activityPostUseCase
    }
    
    init(activityPostUseCase: ActivityPostUseCase, onError: ((String) -> Void)? = nil) {
        self.activityPostUseCase = activityPostUseCase
        self.onError = onError
        
        binding()
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
            
            guard state.postSummaryList.isEmpty else { return }
            
            Task {
                do {
                    let pagination: PostSummaryPagination = try await activityPostUseCase
                        .requestActivityPost(order_by: .likes)
                    
                    state.postSummaryList = pagination.data
                } catch {
                    onError?("사용자 인증이 만료되었습니다.\n다시 로그인 해주세요.")
                }
            }
        }
    }
}
