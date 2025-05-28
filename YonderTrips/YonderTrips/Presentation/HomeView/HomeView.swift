//
//  HomeView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeRouter = HomeFlowRouter()
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    
                    VerticalShadowDivider()
                    
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
                    
                    VerticalShadowDivider()
                    
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.yonderTripsIcon)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: handleNotiToolbarButton){
                        Image(.noti)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.gray75)
                    }
                }
            }
        }
        .navigationDestination(for: HomeFlowRouter.HomeFlow.self) { flow in
            switch flow {
            case .newActivityList:
                print(".newActivityList")
                return Text("")
            case .newActivityDetail:
                print(".newActivityDetail")
                return Text("")
            case .activityPostList:
                print(".activityPostList")
                return Text("")
            case .activityPostDetail:
                print(".activityPostDetail")
                return Text("")
            case .category:
                print(".category")
                return Text("")
            }
        }
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
    
    func handleNotiToolbarButton() {
        print(#function)
    }
}

#Preview {
    HomeView()
}
