//
//  SignInView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/19/25.
//

import SwiftUI
import AuthenticationServices

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct SignInView: View {
    
    @Environment(\.container) private var container
    @Environment(\.networkService) private var networkService
    @StateObject private var signInRouter = SignInFlowRouter()
    
    var body: some View {
        NavigationStack(path: $signInRouter.path) {
            VStack(alignment: .leading) {
                
                Text("YonderTrips.")
                    .lineSpacing(8)
                    .font(Font.yt(.paperlogy(.caption2)))
                    .foregroundColor(.gray15)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(.blackSeafoam)
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                    .padding(.top, 55)
                    .padding(.leading, 16)
                
                Text("Your Trips,\nYonder Bound")
                    .lineSpacing(6)
                    .font(Font.yt(.paperlogy(.slogan1)))
                    .foregroundColor(.gray0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.leading, 16)
                
                Text("저 너머 당신의 멋진 여행을 위해")
                    .font(Font.yt(.paperlogy(.slogan2)))
                    .foregroundColor(.gray30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 1)
                    .padding(.leading, 16)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 8) {
                    
                    // email signIn
                    Button(action: emailLoginButtonAction) {
                        Text("이메일 로그인 • 회원가입")
                            .font(Font.yt(.pretendard(.body1)))
                            .frame(width: 300, height: 45)
                            .background(.gray0)
                            .foregroundColor(.gray90)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray45, lineWidth: 1)
                    }
                    
                    // kakao signIn
                    Button(action: kakaoLoginButtonAction) {
                        Image("kakao_login_large_wide")
                            .resizable()
                            .frame(width: 300, height: 45)
                    }
                    
                    // apple signIn
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        appleLoginButtonAction(result)
                    }
                    .frame(width: 300, height: 45)
                    .signInWithAppleButtonStyle(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                
            }
            .background {
                ZStack {
                    Image("TripsPoster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    Color.gray90.opacity(0.38)
                        .ignoresSafeArea()
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            .navigationDestination(for: SignInFlowRouter.SignInFlow.self) { flow in
                
                switch flow {
                case .emailSignIn:
                    EmailSignInView(viewModel: container.makeEmailSignInViewModel())
                        .environmentObject(signInRouter)
                case .signUp:
                    SignUpView(viewModel: container.makeSignUpViewModel())
                }
            }
        }
    }
}

//MARK: - Action
extension SignInView {
    
    func emailLoginButtonAction() {
        signInRouter.path.append(SignInFlowRouter.SignInFlow.emailSignIn)
        
    }
    
    func appleLoginButtonAction(_ result: Result<ASAuthorization, Error>) {
        
        switch result {
        case .success(let authResults):
            print("Success: \(authResults)")
            
            if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                
                guard let identityToken = appleIDCredential.identityToken,
                      let idToken = String(data: identityToken, encoding: .utf8) else {
                    return
                }
                
                
                let name = appleIDCredential.fullName?.familyName ?? "\(Int.random(in: 1...1000))"
                
                Task {
                    let request = AppleLoginRequestDTO(idToken: idToken, deviceToken: "", nick: name)
                    let response: LoginResponseDTO = try await networkService.request(apiConfiguration: YonderTripsUserAPI.appleLogin(request))
                    
                    print("AppleLoginResponse: \(response)")
                }
            }
            
        case .failure(let failure):
            print("Failure: \(failure)")
        }
    }
    
    func kakaoLoginButtonAction() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    // 성공 시 동작 구현
                    guard let token = oauthToken?.accessToken else { return }
                    print(token)
                    requestKakaoLogin(token)
                }
            }
        } else {
            
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                
                    if let error {
                        print("Error", error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        // 성공 시 동작 구현
                        guard let token = oauthToken?.accessToken else { return }
                        requestKakaoLogin(token)
                    }
                }
        }
        
        func requestKakaoLogin(_ oauthToken: String) {
            print(#function)
            
            Task {
                let request = KakaoLoginRequestDTO(oauthToken: oauthToken, deviceToken: "")
                let response: LoginResponseDTO = try await networkService.request(apiConfiguration: YonderTripsUserAPI.kakaoLogin(request))
                
                print("KakaoLoginResponse: \(response)")
            }
        }
    }
}

#Preview {
    SignInView()
}
