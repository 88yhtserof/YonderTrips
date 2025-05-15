//
//  Font+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/15/25.
//

import SwiftUI

extension Font {
    
    static func yonderTrips(_ type: YonderTripsFont) -> Font {
        
        switch type {
        case .paperlogy(let style):
            return YonderTripsFont.paperlogy(style)
        case .pretendard(let style):
            return YonderTripsFont.pretendard(style)
        }
    }
    
    static func pretendard(_ style: YonderTripsFont.Pretendard) -> Font {
        return YonderTripsFont.pretendard(style)
    }
    
    static func paperlogy(_ style: YonderTripsFont.Paperlogy) -> Font {
        return YonderTripsFont.paperlogy(style)
    }
}
