//
//  EmailSignInView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct EmailSignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject private var signInRouter: SignInFlowRouter
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            titleTextField(title: "이메일", placeholder: "abc@xyz.com", text: $email)
                .padding(.top, 16)
            
            titleTextField(title: "비밀번호", placeholder: "YonderTrips1234@@", text: $password)
            
            Button(action: {
                print("!")
            }) {
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
                
                Button(action: {
                    print("!")
                }) {
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
    }
    
    func titleTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.yt(.pretendard(.caption1)))
            
            SignUpTextField(text: text, placeholder: placeholder)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    EmailSignInView()
}
