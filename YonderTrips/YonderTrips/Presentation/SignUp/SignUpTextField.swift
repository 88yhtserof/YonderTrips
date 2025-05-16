//
//  SignUpTextField.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import SwiftUI

struct SignUpTextField: View {
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack {
                TextField(placeholder, text: $text)
                    .font(.yt(.pretendard(.body1)))
                    .tint(.gray100)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray90)
                    }
                }
            }
            .padding()
            
            // Divider line
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray60)
        }
    }
}
