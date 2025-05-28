//
//  ActivityCategory.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum ActivityCategory: String, CaseIterable {
    case tourism
    case tour
    case package
    case exciting
    case experience
    case random
    
    var title: String {
        switch self {
        case .tourism:
            "관광"
        case .tour:
            "투어"
        case .package:
            "패키지"
        case .exciting:
            "익사이팅"
        case .experience:
            "체험"
        case .random:
            "랜덤"
        }
    }
    
    var image: String {
        return self.rawValue
    }
}
