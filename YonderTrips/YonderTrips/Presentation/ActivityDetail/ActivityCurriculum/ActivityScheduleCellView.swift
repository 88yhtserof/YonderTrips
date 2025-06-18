//
//  ActivityScheduleCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct ActivityScheduleCellView: View {
    
    let item: ActivityScheduleItem
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(item.duration)
                .font(.yt(.pretendard(.caption2)))
                .foregroundStyle(.gray45)
                .padding(.leading, 20)
            
            HStack(spacing: 12) {
                
                Color.lightSeafoam
                    .clipShape(.circle)
                    .frame(width: 8, height: 8)
                
                Text(item.description)
                    .font(.yt(.pretendard(.body3)).weight(.bold))
                    .foregroundStyle(.gray75)
            }
        }
    }
}

#Preview {
    ActivityScheduleCellView(item: ActivityScheduleItem(duration: "시작 - 10분", description: "부상 방지를 위한 기본 스트레칭"))
}
