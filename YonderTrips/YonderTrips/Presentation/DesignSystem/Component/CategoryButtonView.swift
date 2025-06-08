//
//  CategoryButtonView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct CategoryButtonView: View {
    
    let category: ActivityCategory
    @Binding var isSelected: Bool
    let action: (() -> Void)?
    
    init(category: ActivityCategory, isSelected: Binding<Bool>, action: (() -> Void)? = nil) {
        self.category = category
        self._isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button(action: didCategorySelected) {
            
            VStack {
                Image(category.image)
                    .frame(width: 60, height: 60)
                    .background(.gray0)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(category.title)
                    .font(Font.yt(.pretendard(.body2)))
                    .foregroundStyle(.gray90)
            }
        }
        .buttonStyle(SelectedButtonStyle(isSelected: isSelected))
    }
    
    func didCategorySelected() {
        isSelected = true
        action?()
    }
}
