//
//  TokenSecureRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation

struct TokenSecureRepository: TokenRepository {
    
    enum TokenType: String {
        case accessToken, refreshToken
    }
    
    static let service = "YonderTrips.auth"
    
    func saveAuthToken(with tokens: RefreshTokenResponseDTO) throws {
        
        do {
            try save(.accessToken, token: tokens.accessToken)
            try save(.refreshToken, token: tokens.refreshToken)
            
        } catch {
            rollback()
            throw KeyChainError.failedToCreate(TokenSecureRepository.service)
        }
    }
    
    /// Delete the saved access token and refresh token if an error occurs.
    func rollback() {
        
        try? delete(.accessToken)
        try? delete(.refreshToken)
    }
}
