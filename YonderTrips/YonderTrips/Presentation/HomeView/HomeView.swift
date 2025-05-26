//
//  HomeView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                HeaderView(title: "NEW 액티비티", action: handleNewActivityViewAll) {
                    Text("View All")
                        .font(Font.yt(.pretendard(.caption1)))
                        .foregroundStyle(.deepSeafoam)
                }
                
                NewActivityView(list: Array(repeating: "TripsPoster", count: 5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 380)
                
                VerticalDivider()
                
                CategoryView()
                
                Color.lightSeafoam
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .padding(.top, 8)
                
                HeaderView(title: "액티비티 포스트", action: handleActivityPostSort) {
                    HStack {
                        Text("View All")
                            .font(Font.yt(.pretendard(.caption1)))
                    }
                    .foregroundStyle(.deepSeafoam)
                }
                .background(.gray0)
                
                
                ActivityPostView()
            }
        }
        .background(.gray15)
    }
}

//MARK: - Action
private extension HomeView {
    
    func handleNewActivityViewAll() {
        print(#function)
    }
    
    func handleActivityPostSort() {
        print(#function)
    }
}

#Preview {
    HomeView()
}
