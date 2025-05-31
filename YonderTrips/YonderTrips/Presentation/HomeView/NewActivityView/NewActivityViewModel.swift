//
//  NewActivityViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

final class NewActivityViewModel: ViewModelType {
    
    @Published var state = State()
    
    init() {
        binding()
    }
    
    struct State {
        var list = Array<String>()
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
            Task {
                do {
                    let response: ListResponseDTO<ActivitySummaryResponseDTO> = try await NetworkService.requestWithAuth(apiConfiguration: YonderTripsActivityAPI.new(.none, .none))
                    print(response.data.count)
                    state.list = Array(repeating: "", count: response.data.count)
                } catch let error as AuthNetworkError where error == .refreshTokenExpired {
                    print("회원 인증 시간 만료 alert 띄우기")
                }
            }
        }
    }
}
