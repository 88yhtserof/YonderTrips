//
//  ThreeStateButtonStyle.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import SwiftUI

struct ThreeStateButtonStyle: ButtonStyle {
    
    let isSelected: Bool
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .font(.system(size: 14))
            .foregroundStyle(isDisabled ? .gray45 : (isSelected ? .deepSeafoam : .gray75))
            .padding(8)
            .frame(width: 80, height: 40)
            .background(
                isDisabled ? .gray15 :
                    (isSelected ? .lightSeafoam : .gray0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isDisabled ? .gray30 : (isSelected ? .deepSeafoam : .gray30), lineWidth: 1)
            )
            .cornerRadius(20)
    }
}
