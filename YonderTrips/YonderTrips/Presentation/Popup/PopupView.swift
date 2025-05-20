//
//  PopupView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/20/25.
//

import SwiftUI

struct PopupView: View {
    
    let title: String
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ZStack {
            Color.gray90.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
            VStack(spacing: 16) {
                Text(title)
                    .foregroundStyle(.gray90)
                    .font(Font.yt(.pretendard(.body1)))
                
                Button {
                    isPresented = false
                } label: {
                    Text("확인")
                        .foregroundStyle(.gray0)
                        .font(.yt(.pretendard(.body3)))
                }
                .buttonStyle(YTButtonStyle())
            }
            .frame(maxWidth: 300, minHeight: 100)
            .background(.gray0)
            .cornerRadius(12)
            .shadow(radius: 8)
        }
    }
}
