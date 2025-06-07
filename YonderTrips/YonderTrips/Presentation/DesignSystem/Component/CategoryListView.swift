//
//  CategoryListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import SwiftUI

struct CategoryListView: View {
    
    private var categories: [ActivityCategory] = ActivityCategory.allCategories
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    CategoryButtonView(
                        image: category.image,
                        title: category.title,
                        isSelected: Binding (
                            get: { false },
                            set: { _ in }
                        )
                    )
                }
            }
            .padding(8)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoryListView()
}
