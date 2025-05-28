//
//  ActivityCountry.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum ActivityCountry {
    case korea
    case thailand
    case philippines
    case japan
    case australia
    
    var title: String {
        switch self {
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
}
