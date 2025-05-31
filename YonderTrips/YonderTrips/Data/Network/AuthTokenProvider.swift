//
//  AuthTokenProvider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/14/25.
//

import Foundation

enum AuthTokenProvider {
    case access
    case refresh
    
    private static let tokenStorage = TokenSecureStorage()
    
    var token: String? {
        do {
            switch self {
            case .access:
                return try AuthTokenProvider.tokenStorage.fetch(.accessToken)
            case .refresh:
                return try AuthTokenProvider.tokenStorage.fetch(.refreshToken)
            }
        } catch {
            return nil
        }
    }
}
