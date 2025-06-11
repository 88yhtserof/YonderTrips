//
//  LocationTagView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct LocationTagView: View {
    
    let country: String
    
    var body: some View {
        
        HStack {
            Image(.location)
                .resizable()
                .frame(width: 13, height: 13)
            
            Text(country)
                .font(.yt(.pretendard(.caption2)))
        }
        .foregroundColor(.gray0)
        .padding(.vertical, 3)
        .padding(.horizontal, 10)
        .background(.gray0.opacity(0.45))
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray0, lineWidth: 0.6)
        }
    }
}

#Preview {
    LocationTagView(country: "대한민국")
}
