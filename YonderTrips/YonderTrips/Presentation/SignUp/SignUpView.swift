//
//  SignUpView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/15/25.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject private var router: RootFlowRouter
    @StateObject var viewModel: SignUpViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 35) {
                
                VStack(alignment: .leading) {
                    validationTextField(type: .email,
                                        text: $viewModel.state.email,
                                        message: viewModel.state.emailValidationMessage,
                                        state: viewModel.state.emailValidationState)
                    
                    Button {
                        viewModel.action(.validateEmail)
                    } label: {
                        Text("확인")
                            .foregroundStyle(.gray0)
                            .font(.yt(.pretendard(.body3)))
                    }
                    .buttonStyle(YTButtonStyle())
                    
                }
                
                validationTextField(type: .password,
                                    text: $viewModel.state.password,
                                    message: viewModel.state.passwordValidationMessage,
                                    state: viewModel.state.passwordValidationState)
                .onChange(of: viewModel.state.password) { newValue in
                    viewModel.action(.validatePassword(newValue))
                }
                
                validationTextField(type: .nick,
                                    text: $viewModel.state.nickname,
                                    message: viewModel.state.nicknameValidationMessage,
                                    state: viewModel.state.nicknameValidationState)
                .onChange(of: viewModel.state.nickname) { newValue in
                    viewModel.action(.validateNickname(newValue))
                }
                
                textField(type: .phoneNumber, text: $viewModel.state.phoneNumber)
                textField(type: .instruction, text: $viewModel.state.instruction)
                
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray15)
        .navigationTitle("회원가입")
        .navigationBarTitleDisplayMode(.automatic)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.action(.didDoneButtonTapped(router))
                }) {
                    Text("완료")
                }
                .buttonStyle(DisabledButtonStyle())
                .disabled(!viewModel.state.isEnabledDoneButton)
            }
        }
        .overlay {
            if viewModel.state.isShownErrorAlert {
                PopupView(title: viewModel.state.alertMessage, isPresented: $viewModel.state.isShownErrorAlert)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: viewModel.state.isShownErrorAlert)
    }
    
    func validationTextField(type: InputType,
                             text: Binding<String>,
                             message: String?,
                             state: ValidationTextField.ValidationState) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(type.title)을 입력해주세요")
                .font(.yt(.pretendard(.title1)))
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(type.title + (type.isOptional ? " (선택)": " *"))
                        .font(.yt(.pretendard(.caption1)))
                    
                    ValidationTextField(text: text,
                                        placeholder: type.placeholder,
                                        validationMassage: message,
                                        validationState: state)
                }
            }
        }
    }
    
    func textField(type: InputType, text: Binding<String>) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(type.title)을 입력해주세요")
                .font(.yt(.pretendard(.title1)))
            
            VStack(alignment: .leading) {
                Text(type.title + (type.isOptional ? " (선택)": " *"))
                    .font(.yt(.pretendard(.caption1)))
                
                SignUpTextField(text: text,
                                placeholder: type.placeholder)
            }
        }
    }
}

extension SignUpView {
    
    enum InputType {
        case email
        case password
        case nick
        case phoneNumber
        case instruction
        
        var title: String {
            switch self {
            case .email:
                "이메일"
            case .password:
                "비밀번호"
            case .nick:
                "닉네임"
            case .phoneNumber:
                "휴대폰 번호"
            case .instruction:
                "소개글"
            }
        }
        
        var placeholder: String {
            switch self {
            case .email:
                "abc@xyz.com"
            case .password:
                "YonderTrips1234@@"
            case .nick:
                "욘더트립스"
            case .phoneNumber:
                "010-1234-5678"
            case .instruction:
                "반가워요!"
            }
        }
        
        var isOptional: Bool {
            switch self {
            case .email, .password, .nick:
                return false
            default:
                return true
            }
        }
    }
}
