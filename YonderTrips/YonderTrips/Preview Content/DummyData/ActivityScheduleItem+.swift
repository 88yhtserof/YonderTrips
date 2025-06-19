//
//  ActivityScheduleItem+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import Foundation

extension ActivityScheduleItem {
    
    static let items: [ActivityScheduleItem] = [
        ActivityScheduleItem(duration: "시작 - 15분", description: "안전 교육 및 준비 시간이 포함됩니다."),
        ActivityScheduleItem(duration: "30분 - 1시간", description: "기본 훈련 및 장비 점검"),
        ActivityScheduleItem(duration: "1시간 - 2시간", description: "본격적인 체험 시작"),
        ActivityScheduleItem(duration: "마무리 - 20분", description: "정리 및 피드백 시간")
    ]
}
