//
//  CountryListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct CountryListView: View {
    
    enum ListType {
        case search
        case filter
    }
    
    let type: ListType
    
    private var countries: [ActivityCountry] {
        switch type {
        case .search:
            ActivityCountry.allCuntries
        case .filter:
            ActivityCountry.allCases
        }
    }
    
    @State private var selectedCountry: ActivityCountry?
    
    private let colums: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
    
    var body: some View {
        LazyVGrid(columns: colums) {
            
            ForEach(countries, id: \.self) { country in
                CountryButtonView(
                    image: country.image,
                    title: country.title,
                    isSelected: Binding(
                        get: { selectedCountry == country },
                        set: { _ in selectedCountry = country }
                    )
                )
                .frame(maxWidth: 80)
            }
        }

    }
}

#Preview {
    CountryListView(type: .filter)
}


