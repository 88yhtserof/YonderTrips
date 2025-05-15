//
//  YonderTripsFont.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/15/25.
//

import SwiftUI

enum YonderTripsFont {
    case pretendard(Pretendard)
    case paperlogy(Paperlogy)
    
    static func pretendard(_ style: Pretendard) -> Font {
        return style.font
    }
    
    static func paperlogy(_ style: Paperlogy) -> Font {
        return style.font
    }
}

extension YonderTripsFont {
    
    enum Pretendard {
        case title1
        case body1
        case body2
        case body3
        case caption1
        case caption2
        case caption3
        
        var font: Font {
            switch self {
            case .title1:
                return .custom("Pretendard-Bold", size: 20)
            case .body1:
                return .custom("Pretendard-Medium", size: 16)
            case .body2:
                return .custom("Pretendard-Medium", size: 14)
            case .body3:
                return .custom("Pretendard-Medium", size: 13)
            case .caption1:
                return .custom("Pretendard-Regular", size: 12)
            case .caption2:
                return .custom("Pretendard-Regular", size: 10)
            case .caption3:
                return .custom("Pretendard-Regular", size: 8)
            }
        }
    }
    
    enum Paperlogy {
        case title1
        case body1
        case caption1
        
        var font: Font {
            switch self {
            case .title1:
                return .custom("Paperlogy-9Black", size: 26)
            case .body1:
                return .custom("Paperlogy-9Black", size: 22)
            case .caption1:
                return .custom("Paperlogy-9Black", size: 14)
            }
        }
    }
}
