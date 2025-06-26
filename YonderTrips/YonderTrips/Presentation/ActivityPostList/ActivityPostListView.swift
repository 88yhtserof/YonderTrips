//
//  ActivityPostListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/23/25.
//

import SwiftUI

struct ActivityPostListView: View {
    
    @StateObject var viewModel: ActivityPostListViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 0) {
                VerticalShadowDivider()
                
                VStack(spacing: 10) {
                    HStack(spacing: 4) {
                        Text("Distance")
                            .foregroundStyle(.gray45)
                        Text("\(viewModel.state.maxDistanceRounded)KM")
                            .foregroundStyle(.deepSeafoam)
                        Spacer()
                    }
                    .font(.yt(.pretendard(.body1)).bold())
                    .padding(.horizontal, 16)
                    
                    CustomSlider(sliderValue: $viewModel.state.maxDistance)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(.gray15)
                
                if viewModel.state.postSummaryList.isEmpty {
                    Text("아직 게시된 글이 없습니다.")
                        .font(.yt(.pretendard(.body1)))
                        .foregroundStyle(.gray60)
                } else {
                    VStack {
                        ForEach(viewModel.state.postSummaryList, id: \.postId) { item in
                            ActivityPostCellView(postSummary: item)
                            
                            VerticalDivider()
                        }
                    }
                }
            }
        }
        .background(.gray0)
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Text("액티비티 포스트")
                    .font(.yt(.paperlogy(.caption1)))
                    .foregroundStyle(.deepSeafoam)
            }
        }
        .onAppear {
            viewModel.action(.requestCurrentLocation)
        }
        .onChange(of: viewModel.state.maxDistance) { value in
            viewModel.action(.requestList(shouldReplaceList: true))
        }
    }
}
