//
//  ActivityCountry.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum ActivityCountry: String, CaseIterable {
    case none
    case korea
    case thailand
    case philippines
    case japan
    case australia
    
    var query: String {
        switch self {
        case .none:
            return ""
        case .korea:
            return "대한민국"
        case .thailand:
            return "태국"
        case .philippines:
            return "필리핀"
        case .japan:
            return "일본"
        case .australia:
            return "오스트레일리아"
        }
    }
    
    var title: String {
        switch self {
        case .none:
            return "전체"
        case .korea:
            return "대한민국"
        case .thailand:
            return "태국"
        case .philippines:
            return "필리핀"
        case .japan:
            return "일본"
        case .australia:
            return "오스트레일리아"
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
    
    /// All countries except .none
    static var allCuntries: [ActivityCountry] {
        return [.korea, .thailand, .philippines, .japan, .australia]
    }
}
