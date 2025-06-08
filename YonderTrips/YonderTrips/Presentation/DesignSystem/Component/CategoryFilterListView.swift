//
//  CategoryFilterListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct CategoryFilterListView: View {
    
    private var categories: [ActivityCategory] = ActivityCategory.allCases
    
    private let colums: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
    
    @Binding var selectedCategory: ActivityCategory
    
    init(selectedCategory: Binding<ActivityCategory>) {
        self._selectedCategory = selectedCategory
    }
    
    var body: some View {
        LazyVGrid(columns: colums) {
            ForEach(categories, id: \.self) { category in
                CategoryButtonView(
                    image: category.image,
                    title: category.title,
                    isSelected: Binding(
                        get: { selectedCategory == category },
                        set: { _ in selectedCategory = category }
                    )
                )
            }
        }
    }
}
