//
//  ActivityCategory.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum ActivityCategory: String, CaseIterable {
    case none
    case tourism
    case tour
    case package
    case exciting
    case experience
    case random
    
    var query: String {
        switch self {
        case .none:
            ""
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
    
    var title: String {
        switch self {
        case .none:
            "전체"
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
        switch self {
        case .none:
            return "all"
        default:
            return self.rawValue
        }
    }
    
    /// All categories except .none
    static var allCategories: [ActivityCategory] {
        return [.tourism, .tour, .package, .exciting, .experience, .random]
    }
}
