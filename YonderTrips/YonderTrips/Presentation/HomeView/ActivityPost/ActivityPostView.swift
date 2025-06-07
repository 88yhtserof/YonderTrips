//
//  ActivityPostView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

struct ActivityPostView: View {
    
    @StateObject var viewModel: ActivityPostViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.state.postSummaryList, id: \.postId) { item in
                ActivityPostCellView(postSummary: item)
                
                VerticalDivider()
            }
        }
        .background(.gray0)
        .onAppear {
            viewModel.action(.onAppear)
        }
    }
}
