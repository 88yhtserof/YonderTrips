//
//  MessageTokenRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/26/25.
//

import Foundation

struct MessageTokenRepository: TokenRepository {
    
    enum TokenType: String {
        case fcmToken
    }
    
    static let service = "YonderTrips.message"
}

