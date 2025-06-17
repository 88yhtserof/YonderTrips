//
//  AuthorizationProvider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation

enum AuthorizationProvider: String {
    case yonderTrips = "YONDERTRIPS"
    case kakao = "KAKAO"
    case iamport = "IAMPORT"
    
    var apiKey: String? {
        return Bundle.main.infoDictionary?["\(self.rawValue)_API_KEY"] as? String
    }
    
    var url: String? {
        return Bundle.main.infoDictionary?["\(self.rawValue)_URL"] as? String
    }
    
    var scheme: String? {
        return Bundle.main.infoDictionary?["\(self.rawValue)_SCHEME"] as? String
    }
}
