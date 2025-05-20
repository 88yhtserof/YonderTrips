//
//  ValidationTextField.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import SwiftUI

struct ValidationTextField: View {
    
    enum ValidationState {
        case valid
        case invalid
        case none
        
        var color: Color {
            switch self {
            case .valid:
                return .blackSeafoam
            case .invalid:
                return .red
            case .none:
                return .gray60
            }
        }
    }
    
    @Binding var text: String
    let placeholder: String
    let validationMassage: String?
    let validationState: ValidationState
    
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
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            
            // Divider line
            Rectangle()
                .frame(height: 1)
                .foregroundColor(validationState.color)
            
            // Error message with animation
            if let validationMassage {
                Text(validationMassage)
                    .foregroundColor(validationState.color)
                    .font(.system(size: 14))
                    .padding(.top, 8)
            }
        }
    }
}
