//
//  HomeView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.container) var container
    @StateObject private var homeRouter = HomeFlowRouter()
    
    var body: some View {
        
        NavigationStack(path: $homeRouter.path) {
            ScrollView {
                VStack(spacing: 0) {
                    
                    VerticalShadowDivider()
                    
                    HeaderView(title: "NEW 액티비티", action: handleNewActivityViewAll) {
                        Text("View All")
                            .font(Font.yt(.pretendard(.caption1)))
                            .foregroundStyle(.deepSeafoam)
                    }
                    
                    NewActivityView(viewModel: container.makeNewActivityViewModel())
                        .frame(maxWidth: .infinity)
                        .frame(height: 360)
                        .padding(.bottom, 8)
                    
                    VerticalDivider()
                    
                    CategoryListView(){ selectedCategory in
                        handleCategory(with: selectedCategory)
                    }
                    
                    VerticalShadowDivider()
                    
                    HeaderView(title: "HOT 액티비티 포스트", action: handleActivityPostViewAll) {
                        HStack {
                            Text("View All")
                                .font(Font.yt(.pretendard(.caption1)))
                        }
                        .foregroundStyle(.deepSeafoam)
                    }
                    .background(.gray0)
                    
                    // 액세스 토큰 적용 오류를 해결하기 위해 임시 주석처리
//                    ActivityPostView(viewModel: container.makeActivityPostViewModel())
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
            .navigationDestination(for: HomeFlowRouter.HomeFlow.self) { flow in
                
                switch flow {
                case .newActivityList:
                    Text("")
                case .newActivityDetail:
                    Text("")
                case .activityPostList:
                    Text("")
                case .activityPostDetail:
                    Text("")
                case .category:
                    Text("")
                case let .activityFilter(category, country):
                    ActivityFilterView(selectedCategory: category, selectedCountry: country)
                }
            }
        }
    }
}

//MARK: - Action
private extension HomeView {
    
    func handleNewActivityViewAll() {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.activityFilter(.none, .none))
    }
    
    func handleActivityPostViewAll() {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.activityFilter(.none, .none))
    }
    
    func handleCategory(with category: ActivityCategory) {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.activityFilter(category, .none))
    }
    
    func handleNotiToolbarButton() {
        print(#function)
    }
}

#Preview {
    HomeView()
}
