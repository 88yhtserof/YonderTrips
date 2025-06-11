//
//  ActivityListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct ActivityListView: View {
    
    let selectedCategory: ActivityCategory
    let selectedCountry: ActivityCountry
    
    var body: some View {
        
        ScrollView {
            VStack {
                ForEach(0..<10) { _ in
                    ActivityListCellView()
                    
                    VerticalDivider()
                }
            }
        }
        .background(.gray15)
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationTitleView(title: selectedCategory.title_en)
            }
        }
    }
}

#Preview {
    ActivityListView(selectedCategory: .exciting, selectedCountry: .none)
}
