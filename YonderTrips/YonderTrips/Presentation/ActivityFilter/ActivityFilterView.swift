//
//  ActivityFilterView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/6/25.
//

import SwiftUI

struct ActivityFilterView: View {
    
    @State var selectedCategory: ActivityCategory
    @State var selectedCountry: ActivityCountry
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(spacing: -12) {
                    HeaderView<EmptyView>(title: "카테고리")
                    
                    CategoryFilterListView(selectedCategory: $selectedCategory)
                }
                
                VerticalDivider()
                    .padding(.top, 8)
                
                VStack(spacing: -12) {
                    HeaderView<EmptyView>(title: "국가")
                    
                    CountryFilterListView(selectedCountry: $selectedCountry)
                }
                
                Spacer()
            }
        }
    }
}
