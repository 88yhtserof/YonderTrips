//
//  NavigationTitleView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import SwiftUI

struct NavigationTitleView: View {
    
    let title: String
    
    var body: some View {
        
        Text(title)
            .font(.yt(.paperlogy(.caption1)))
            .foregroundStyle(.deepSeafoam)
    }
}

#Preview {
    NavigationTitleView(title: "EXCITING")
}
