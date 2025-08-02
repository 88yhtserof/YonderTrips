//
//  WebViewModalView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/30/25.
//

import SwiftUI
import WebKit

struct WebViewModalView: View {
    let url: String
    @Environment(\.dismiss) private var dismiss
    @StateObject private var coordinator = WebViewBridgeCoordinator()
    
    var body: some View {
        NavigationView {
            ZStack {
                WebViewBridgeView(url: url, coordinator: coordinator)
                
                if coordinator.isLoading {
                    ProgressView()
                        .scaleEffect(1.2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.1))
                }
            }
            .navigationTitle("이벤트")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("닫기") {
                        dismiss()
                    }
                    .foregroundStyle(.gray90)
                    .font(.yt(.pretendard(.caption1)))
                }
            }
        }
        .alert("출석 완료", isPresented: $coordinator.showAlert) {
            Button("확인") {
                coordinator.showAlert = false
            }
        } message: {
            Text(coordinator.alertMessage)
        }
    }
}
