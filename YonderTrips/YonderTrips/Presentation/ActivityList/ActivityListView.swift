//
//  ActivityListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct ActivityListView: View {
    
    @StateObject var viewModel: ActivityListViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                AdvertisementBannerView(
                    viewModel: AdvertisementBannerViewModel(
                        bannerService: LiveBannerRepository()
                    )
                )
                
                VerticalShadowDivider()
                
                HeaderView<EmptyView>(title: "액티비티")
                
                LazyVStack {
                    ForEach(viewModel.state.activityList, id: \.activityId) { activity in
                        ActivityListCellView(activity: activity)
                        
                        if let last = viewModel.state.activityList.last,
                           last.activityId == activity.activityId {
                            sendAction(.pagination)
                        } else {
                            VerticalDivider()
                        }
                    }
                }
            }
        }
        .background(.gray15)
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationTitleView(title: viewModel.category.title_en)
            }
        }
        .onAppear {
            viewModel.action(.onAppear)
        }
    }
    
    func sendAction(_ action: ActivityListViewModel.Action) -> some View {
        viewModel.action(action)
        return EmptyView()
    }
}
