//
//  SignInView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/19/25.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @Environment(\.networkService) private var networkService
    
    var body: some View {
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
            
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                appleLoginButtonAction(result)
            }
            .frame(height: 45)
            .padding(15)
            .signInWithAppleButtonStyle(.black)
            
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
}

#Preview {
    SignInView()
}
