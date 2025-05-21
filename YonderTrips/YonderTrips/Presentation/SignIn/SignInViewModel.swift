//
//  SignInViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import Foundation

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class SignInViewModel: ViewModelType {
    
    @Published var state = State()
    private let signInUseCase: SignInUseCase
    private let logger: YonderTripsLogger
    
    init(signInUseCase: SignInUseCase, logger: YonderTripsLogger) {
        self.signInUseCase = signInUseCase
        self.logger = logger
    }
    
    struct State {
        
        var isShownErrorAlert: Bool = false
        var alertMessage: String = ""
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension SignInViewModel {
    
    enum Action {
        case didKakaoSignInButtonTapped(RootFlowRouter)
    }
    
    @MainActor
    func action(_ action: Action) {
        
        switch action {
        case .didKakaoSignInButtonTapped(let router):
            kakaoLoginButtonAction(router)
        }
    }
    
    // detail action
    @MainActor
    func kakaoLoginButtonAction(_ router: RootFlowRouter) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    self?.state.alertMessage = error.localizedDescription
                    self?.state.isShownErrorAlert = true
                }
                else {
                    self?.logger.debug("Success: SignIn with Kakao by KakaoTalk")
                    
                    guard let token = oauthToken?.accessToken else { return }
                    
                    Task {
                        do {
                            try await self?.signInUseCase.requestSignInWithKakao(oauthToken: token)
                            router.rootFlow = .home
                            
                        } catch {
                            self?.state.alertMessage = error.localizedDescription
                            self?.state.isShownErrorAlert = true
                        }
                    }
                }
            }
        } else {
            
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                
                    if let error {
                        self?.state.alertMessage = error.localizedDescription
                        self?.state.isShownErrorAlert = true
                    }
                    else {
                        self?.logger.debug("Success: SignIn with Kakao by Account")
                        guard let token = oauthToken?.accessToken else { return }
                        
                        Task {
                            do {
                                try await self?.signInUseCase.requestSignInWithKakao(oauthToken: token)
                                router.rootFlow = .home
                            } catch {
                                self?.state.alertMessage = error.localizedDescription
                                self?.state.isShownErrorAlert = true
                            }
                        }
                    }
                }
        }
    }
}
