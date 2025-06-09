//
//  CountryFilterListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct CountryFilterListView: View {
    
    private var countries: [ActivityCountry] = ActivityCountry.allCases
    
    @Binding var selectedCountry: ActivityCountry
    
    init(selectedCountry: Binding<ActivityCountry>) {
        self._selectedCountry = selectedCountry
    }
    
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

