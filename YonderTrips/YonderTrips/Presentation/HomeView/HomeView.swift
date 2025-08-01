//
//  HomeView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.container) var container
    @EnvironmentObject private var router: RootFlowRouter
    @EnvironmentObject private var homeRouter: HomeFlowRouter
    
    @State private var showErrorPopup = false
    @State private var errorMessage: String = ""
    
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
                    
                    NewActivityView(viewModel: container.makeNewActivityViewModel(onError: handleRefreshError))
                        .frame(maxWidth: .infinity)
                        .frame(height: 360)
                        .padding(.bottom, 8)
                        .environmentObject(homeRouter)
                    
                    VerticalDivider()
                    
                    CategoryListView(){ selectedCategory in
                        handleCategory(with: selectedCategory)
                    }
                    .padding(.bottom, 16)
                    
                    VerticalShadowDivider()
                    
                    HeaderView(title: "HOT 액티비티 포스트", action: handleActivityPostViewAll) {
                        HStack {
                            Text("View All")
                                .font(Font.yt(.pretendard(.caption1)))
                        }
                        .foregroundStyle(.deepSeafoam)
                    }
                    .background(.gray0)
                    
                    ActivityPostView(viewModel: container.makeActivityPostViewModel(onError: handleRefreshError))
                }
            }
            .background(.gray15)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(.yonderTripsIcon)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: handleNotiToolbarButton){
                        Image(.keepEmpty)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.gray75)
                    }
                }
            }
            .overlay {
                if showErrorPopup {
                    PopupView(title: errorMessage,
                              isPresented: $showErrorPopup,
                              action: handleOnErrorPopup)
                }
            }
            .ytNavigationDestination(for: HomeFlowRouter.HomeFlow.self) { flow in
                
                switch flow {
                case let .activityList(category, country):
                    ActivityListView(viewModel: container.makeActivityListViewModel(category: category, country: country))
                        .environmentObject(homeRouter)
                    
                case .activityDetail(let activity):
                    ActivityDetailView(activityDetailViewMdoel: ActivityDetailViewModel(activity: activity), orderViewMdoel: container.makeOrderViewModel())
                        .environmentObject(homeRouter)
                    
                case let .activityPostList(category, country):
                    ActivityPostListView(viewModel: container.makeActivityPostListViewModel(category: category, country: country))
                    
                case .activityPostDetail:
                    Text("")
                case let .activityFilter(category, country, flow):
                    ActivityFilterView(selectedCategory: category, selectedCountry: country, flow: flow)
                        .environmentObject(homeRouter)
                
                case .chatRoomList:
                    ChatRoomListView(viewModel: container.makeChatRoomListViewModel())
                        .environmentObject(homeRouter)
                case .chat(let userId):
                    ChatView(viewModel: container.makeChatViewModel(opponentId: userId))
                }
            }
        }
    }
}

//MARK: - Action
private extension HomeView {
    
    func handleRefreshError(_ message: String) {
        errorMessage = message
        showErrorPopup = true
    }
    
    func handleOnErrorPopup() {
        router.rootFlow = .signIn
    }
    
    func handleNewActivityViewAll() {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.activityFilter(.none, .none, .activityList(.none, .none)))
    }
    
    func handleActivityPostViewAll() {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.activityFilter(.none, .none, .activityPostList(.none, .none)))
    }
    
    func handleCategory(with category: ActivityCategory) {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.activityFilter(category, .none, .activityList(category, .none)))
    }
    
    func handleNotiToolbarButton() {
        homeRouter.path.append(HomeFlowRouter.HomeFlow.chatRoomList)
    }
}

#Preview {
    HomeView()
}
