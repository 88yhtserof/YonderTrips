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
            
            VStack {
                CustomSlider()
                    .padding(16)
                
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
        .onAppear {
            
            viewModel.action(.requestCurrentLocation)
        }
    }
}
