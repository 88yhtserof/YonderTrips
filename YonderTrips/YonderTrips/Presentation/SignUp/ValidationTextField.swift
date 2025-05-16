//
//  ValidationTextField.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import SwiftUI

struct ValidationTextField: View {
    
    @Binding var text: String
    let placeholder: String
    let validationError: String? = nil
    @State private var isShowingError = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // TextField with clear button
            HStack {
                TextField(placeholder, text: $text)
                    .font(.yt(.pretendard(.body1)))
                    .tint(.gray100)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            
            // Divider line
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isShowingError ? .red : .gray)
            
            // Error message with animation
            if let error = validationError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(.top, 8)
                    .opacity(isShowingError ? 1 : 0)
                    .offset(x: isShowingError ? 0 : -10)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.3)) {
                            isShowingError = true
                        }
                    }
                    .onDisappear {
                        isShowingError = false
                    }
            }
        }
        .onChange(of: validationError) { _ in
            if validationError != nil {
                isShowingError = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        isShowingError = true
                    }
                }
            }
        }
    }
}
