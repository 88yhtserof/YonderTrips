//
//  CountryButtonView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/7/25.
//

import SwiftUI

struct CountryButtonView: View {
    
    var image: String
    var title: String
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: didCountrySelected) {
            
            VStack {
                Image(image)
                    .frame(width: 80, height: 60)
                    .background(.gray0)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(title)
                    .font(Font.yt(.pretendard(.body2)))
                    .foregroundStyle(.gray90)
            }
            .frame(width: 90)
        }
        .buttonStyle(SelectedButtonStyle(isSelected: isSelected))
    }
    
    func didCountrySelected() {
        isSelected = true
    }
}
