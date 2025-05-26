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
            
            HeaderView(title: "NEW 액티비티", action: handleNewActivityViewAll) {
                Text("View All")
                    .font(Font.yt(.pretendard(.caption1)))
                    .foregroundStyle(.deepSeafoam)
            }
            .padding(.horizontal, 16)
            
            NewActivityView(list: Array(repeating: "TripsPoster", count: 5))
                .frame(maxWidth: .infinity)
                .frame(height: 380)
            
            divider()
            
            CategoryView()
            
            divider()
            
            HeaderView(title: "액티비티 포스트", action: handleActivityPostSort) {
                HStack {
                    Text("최신순")
                        .font(Font.yt(.pretendard(.caption1)))
                    
                    Image(systemName: "text.alignleft")
                }
                .foregroundStyle(.deepSeafoam)
            }
            .padding(.horizontal, 16)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray15)
    }
}

//MARK: - Action
private extension HomeView {
    
    func divider() -> some View {
        
        Divider()
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
    }
    
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
