//
//  ActivityPostView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

struct ActivityPostView: View {
    var body: some View {
        VStack {
            ForEach(0..<5, id: \.self) { _ in
                ActivityPostCellView()
                
                VerticalDivider()
            }
        }
        .background(.gray0)
    }
}

#Preview {
    ActivityPostView()
}
