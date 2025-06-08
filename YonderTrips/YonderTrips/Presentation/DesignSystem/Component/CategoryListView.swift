//
//  CategoryListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import SwiftUI

struct CategoryListView: View {
    
    let action: (ActivityCategory) -> Void
    
    private var categories: [ActivityCategory] = ActivityCategory.allCases
    
    init(action: @escaping (ActivityCategory) -> Void) {
        self.action = action
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    CategoryButtonView(
                        category: category,
                        isSelected: Binding (
                            get: { false },
                            set: { _ in }
                        )
                    ) { action(category) }
                }
            }
            .padding(8)
        }
        .scrollIndicators(.hidden)
    }
}
