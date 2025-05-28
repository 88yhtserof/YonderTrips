//
//  CategoryView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import SwiftUI

struct CategoryView: View {
    
    private let categories = ActivityCategory.allCases
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    categoryButtonStyle(category)
                }
            }
            .padding(8)
        }
        .scrollIndicators(.hidden)
    }
}

//MARK: - View
extension CategoryView {
    
    func categoryButtonStyle(_ category: ActivityCategory) -> some View {
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
}

#Preview {
    CategoryView()
}
