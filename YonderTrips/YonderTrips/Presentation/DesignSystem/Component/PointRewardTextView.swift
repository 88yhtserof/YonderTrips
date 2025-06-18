//
//  PointRewardTextView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct PointRewardTextView: View {
    
    let pointReward: Int
    
    var body: some View {
        
        HStack(spacing: 2) {
            Image(.point)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.blackSeafoam)
            
            Text("\(pointReward)P")
                .font(.yt(.paperlogy(.caption2)))
                .foregroundStyle(.gray60)
        }

    }
}

#Preview {
    PointRewardTextView(pointReward: 100)
}
