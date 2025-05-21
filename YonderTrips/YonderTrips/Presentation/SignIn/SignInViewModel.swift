//
//  SignInViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import Foundation
import AuthenticationServices

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
        case didAppleSignInButtonTapped(Result<ASAuthorization, Error>, RootFlowRouter)
    }
    
    @MainActor
    func action(_ action: Action) {
        
        switch action {
        case .didKakaoSignInButtonTapped(let router):
            kakaoLoginButtonAction(router)
        case let .didAppleSignInButtonTapped(result, router):
            Task {
                do {
                    try await appleLoginButtonAction(result)
                    router.rootFlow = .home
                } catch {
                    state.alertMessage = "Apple ID 로그인에 실패했습니다."
                    state.isShownErrorAlert = true
                }
            }
        }
    }
    
    // detail action
    @MainActor
    func kakaoLoginButtonAction(_ router: RootFlowRouter) {
        let errorMessage = "카카오 로그인에 실패했습니다."
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    self?.state.alertMessage = errorMessage
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
                            self?.state.alertMessage = errorMessage
                            self?.state.isShownErrorAlert = true
                        }
                    }
                }
            }
        } else {
            
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                
                if let _ = error {
                    self?.state.alertMessage = errorMessage
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
                            self?.state.alertMessage = errorMessage
                            self?.state.isShownErrorAlert = true
                        }
                    }
                }
            }
        }
    }
    
    func appleLoginButtonAction(_ result: Result<ASAuthorization, Error>) async throws {
        
        switch result {
        case .success(let authResults):
            logger.debug("Success: SignIn with Apple")
            
            if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                
                guard let identityToken = appleIDCredential.identityToken,
                      let token = String(data: identityToken, encoding: .utf8) else {
                    return
                }
                
                
                let nick = appleIDCredential.fullName?.familyName ?? "\(Int.random(in: 1...1000))"
                
                try await signInUseCase.requestSignInWithApple(idToken: token, nick: nick)
            }
            
        case .failure(let error):
            throw error
        }
    }
}
