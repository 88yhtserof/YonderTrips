//
//  EmailSignInView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct EmailSignInView: View {
    
    @StateObject var viewModel: EmailSignInViewModel
    @EnvironmentObject private var signInRouter: SignInFlowRouter
    @EnvironmentObject private var rootRouter: RootFlowRouter
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            titleTextField(title: "이메일", placeholder: "abc@xyz.com", text: $viewModel.state.email)
                .padding(.top, 16)
            
            titleTextField(title: "비밀번호", placeholder: "YonderTrips1234@@", text: $viewModel.state.password)
            
            Button(action: signInButtonAction) {
                Text("로그인")
                    .foregroundStyle(.gray0)
                    .font(.yt(.pretendard(.body2)))
            }
            .buttonStyle(YTButtonStyle())
            .padding(.horizontal, 16)
            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("아직 계정이 없으신가요?")
                    .foregroundStyle(.gray75)
                    .font(.yt(.pretendard(.body2)))
                
                Button(action: signInUpWithEmailButtonAction) {
                    VStack(alignment: .leading) {
                        Text("이메일로 회원가입 하기")
                            .foregroundStyle(.gray75)
                            .font(.yt(.pretendard(.body2)))
                        Divider()
                    }
                }
                .frame(width: 135)
                
            }
            .padding(.leading, 16)
            
            Spacer()
        }
        .navigationTitle("로그인")
        .navigationBarTitleDisplayMode(.large)
        .overlay {
            if viewModel.state.isShownErrorAlert {
                PopupView(title: viewModel.state.alertMessage,
                          isPresented: $viewModel.state.isShownErrorAlert)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.state.isShownErrorAlert)
    }
}

//MARK: - View
extension EmailSignInView {
    
    func titleTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.yt(.pretendard(.caption1)))
            
            SignUpTextField(text: text, placeholder: placeholder)
        }
        .padding(.horizontal, 16)
    }
}

//MARK: - Action
extension EmailSignInView {
    
    func signInButtonAction() {
        viewModel.action(.didSignInButtonTapped(rootRouter))
    }
    
    func signInUpWithEmailButtonAction() {
        signInRouter.path.append(SignInFlowRouter.SignInFlow.signUp)
    }
}
