//
//  ActivityFilterView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/6/25.
//

import SwiftUI

struct ActivityFilterView: View {
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(spacing: -12) {
                    HeaderView<EmptyView>(title: "카테고리")
                    
                    CategoryFilterListView()
                }
                
                VerticalDivider()
                    .padding(.top, 8)
                
                VStack(spacing: -12) {
                    HeaderView<EmptyView>(title: "국가")
                    
                    CountryListView(type: .filter)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ActivityFilterView()
}
