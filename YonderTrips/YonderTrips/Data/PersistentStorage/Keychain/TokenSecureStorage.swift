//
//  TokenSecureStorage.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation

struct TokenSecureStorage {
    
    private let storage = KeychainSecureStorage.shared
    
    static let service = "YonderTrips.auth"
    
    enum TokenType: String {
        case accessToken
        case refreshToken
        
        var key: String {
            return self.rawValue
        }
    }
    
    func saveAuthToken(with tokens: RefreshTokenResponseDTO) throws {
        
        do {
            try save(.accessToken, token: tokens.accessToken)
            try save(.refreshToken, token: tokens.refreshToken)
            
        } catch {
            rollback()
            throw KeyChainError.failedToCreate(TokenSecureStorage.service)
        }
    }
    
    func save(_ type: TokenType, token: String) throws {
        
        let tokenData = token.data(using: .utf8)!
        
        try storage.create(tokenData, forKey: type.key, service: TokenSecureStorage.service, itemClass: .genericPassword)
    }
    
    func fetch(_ type: TokenType) throws -> String {
        
        let tokenData = try storage.read(forKey: type.key, service: TokenSecureStorage.service, itemClass: .genericPassword)
        
        guard let token = String(data: tokenData, encoding: .utf8) else {
            throw KeyChainError.invalidData
        }
        
        return token
    }
    
    func update(_ type: TokenType, token: String) throws {
        
        let tokenData = token.data(using: .utf8)!
        
        try storage.update(forKey: type.key, value: tokenData, itemClass: .genericPassword)
    }
    
    func delete(_ type: TokenType) throws {
        
        try storage.delete(forKey: type.key, service: TokenSecureStorage.service, itemClass: .genericPassword)
    }
    
    /// Delete the saved access token and refresh token if an error occurs.
    func rollback() {
        
        try? delete(.accessToken)
        try? delete(.refreshToken)
    }
}
