//
//  SelectedButtonStyle.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct SelectedButtonStyle: ButtonStyle {
    
    var isSelected: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .overlay {
                
                if isSelected {
                    ZStack {
                        Color.gray0.opacity(0.65)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.gray90)
                    }
                }
            }
    }
}
