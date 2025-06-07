//
//  CategoryButtonView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct CategoryButtonView: View {
    
    var image: String
    var title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: didCategorySelected) {
            
            VStack {
                Image(image)
                    .frame(width: 60, height: 60)
                    .background(.gray0)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(title)
                    .font(Font.yt(.pretendard(.body2)))
                    .foregroundStyle(.gray90)
            }
        }
        .buttonStyle(SelectedButtonStyle(isSelected: isSelected))
    }
    
    func didCategorySelected() {
        isSelected = true
    }
}
