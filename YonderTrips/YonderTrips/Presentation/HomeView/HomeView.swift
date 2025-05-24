//
//  HomeView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct Category {
    let title: String
    let image: String
}

struct HomeView: View {
    
    var body: some View {
        
        VStack {
            
            sample()
            NewActivityView(list: Array(repeating: "TripsPoster", count: 5))
                .frame(maxWidth: .infinity)
                .frame(height: 300)
            
            Divider()
                .padding(.horizontal, 16)
            CategoryView()
            Divider()
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray15)
    }
    
    func sample() -> some View {
        print("Rendering")
        return Text("")
    }
}

#Preview {
    HomeView()
}
