//
//  SignUpView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/15/25.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var nick: String = ""
    @State private var phoneNumber: String = ""
    @State private var instruction: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 35) {
                    
                    inputView(type: .email, text: $email)
                    inputView(type: .password, text: $password)
                    inputView(type: .nick, text: $nick)
                    
                    inputView(type: .phoneNumber, text: $phoneNumber)
                    inputView(type: .instruction, text: $instruction)
                    
                }
                .padding(10)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray15)
            .navigationTitle("회원가입")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // 버튼 눌렀을 때 동작
                        print("완료 버튼 눌림")
                    }) {
                        Text("완료")
                            .font(.yt(.pretendard(.body1)))
                            .foregroundStyle(.gray100)
                    }
                }
            }
        }
    }
    
    func inputView(type: InputType, text: Binding<String>) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("\(type.title)을 입력해주세요")
                .font(.yt(.pretendard(.title1)))
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(type.title)
                        .font(.yt(.pretendard(.caption1)))
                    
                    ValidationTextField(text: text,
                                        placeholder: type.placeholder)
                }
                
                if type.isNeededButton {
                    Button {
                        print("유효성 검사")
                    } label: {
                        Text("확인")
                            .padding(10)
                            .foregroundStyle(.gray0)
                            .font(.yt(.pretendard(.body3)))
                    }
                    .background(.blackSeafoam)
                    .clipShape(RoundedRectangle(cornerRadius: 3.6))
                }
                
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
        
        var isNeededButton: Bool {
            switch self {
            case .email:
                return true
            default:
                return false
            }
        }
    }
}

#Preview {
    SignUpView()
}


