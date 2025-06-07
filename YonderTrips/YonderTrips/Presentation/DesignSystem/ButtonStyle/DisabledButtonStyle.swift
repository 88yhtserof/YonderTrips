//
//  DisabledButtonStyle.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/18/25.
//

import SwiftUI

struct DisabledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled)
    var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.yt(.pretendard(.body1)))
            .foregroundColor(isEnabled ? .gray90 : .gray60)
            .padding(10)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
