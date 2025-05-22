//
//  EmailSignInViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import Foundation

final class EmailSignInViewModel: ViewModelType {
    
    @Published var state = State()
    private let signInUseCase: SignInUseCase
    
    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
        self.state = state
    }
    
    struct State {
        var email: String = ""
        var password: String = ""
        
        var isShownErrorAlert: Bool = false
        var alertMessage: String = ""
    }
    
    func binding() {
        
    }
}


//MARK: - Action
extension EmailSignInViewModel {
    
    enum Action {
        case didSignInButtonTapped(RootFlowRouter)
    }
    
    @MainActor
    func action(_ action: Action) {
        
        switch action {
        case .didSignInButtonTapped(let router):
            guard !state.email.isEmpty && !state.password.isEmpty else {
                state.alertMessage = "이메일 또는 비밀번호를 입력하세요."
                state.isShownErrorAlert = true
                return
            }
            
            Task {
                do {
                    try await signInUseCase.requestSignInWithEmail(email: state.email, password: state.password)
                    
                    router.rootFlow = .home
                } catch {
                    state.alertMessage = error.localizedDescription
                    state.isShownErrorAlert = true
                }
            }
        }
    }
}
