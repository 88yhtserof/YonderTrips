//
//  YTNavigationBarBackButtonModifier.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/8/25.
//

import SwiftUI

struct YTNavigationBarBackButtonModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.gray75)
                    }
                    .accessibilityLabel("뒤로 가기")
                }
            }
    }
}

extension View {
    
    func ytNavigationBarBackButton() -> some View {
        self.modifier(YTNavigationBarBackButtonModifier())
    }
}
