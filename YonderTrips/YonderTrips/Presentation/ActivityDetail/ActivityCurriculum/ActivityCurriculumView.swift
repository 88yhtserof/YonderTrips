//
//  ActivityCurriculumView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct ActivityCurriculumView: View {
    
    let items: [ActivityScheduleItem] = [
        ActivityScheduleItem(duration: "시작 - 15분", description: "안전 교육 및 준비 시간이 포함됩니다."),
        ActivityScheduleItem(duration: "30분 - 1시간", description: "기본 훈련 및 장비 점검"),
        ActivityScheduleItem(duration: "1시간 - 2시간", description: "본격적인 체험 시작"),
        ActivityScheduleItem(duration: "마무리 - 20분", description: "정리 및 피드백 시간")
    ]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            SubheaderView(title: "액티비티 커리큘럼")
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: -16) {
                    
                    ForEach(items, id: \.self) { item in
                        
                        VStack(alignment: .leading, spacing: 4) {
                            ActivityScheduleCellView(item: item)
                            
                            if let last = items.last, last != item {
                                Color.lightSeafoam
                                    .frame(width: 2, height: 28)
                                    .padding(.leading, 3)
                            }
                        }
                    }
                }
                
                LocationView(region: ActivityGeolocation(longitude: 46.3997, latitude: 8.1286))
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray0)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray30, lineWidth: 0.6)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ActivityCurriculumView()
}

