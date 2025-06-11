//
//  PageIndicatorView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import SwiftUI

struct PageIndicatorView: View {
    let currentIndex: Int
    let totalCount: Int
    
    var body: some View {
        
        HStack {
            Text("\(currentIndex)/\(totalCount)")
                .font(.yt(.pretendard(.caption2)))
        }
        .foregroundColor(.gray0)
        .padding(.vertical, 3)
        .padding(.horizontal, 10)
        .background(.gray90.opacity(0.45))
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray90, lineWidth: 0.6)
        }
    }
}
