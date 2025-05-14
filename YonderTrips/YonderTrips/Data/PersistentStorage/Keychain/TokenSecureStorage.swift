//
//  TokenSecureStorage.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation

struct TokenSecureStorage {
    
    private let storage: KeychainSecureStorage
    
    init(storage: KeychainSecureStorage) {
        self.storage = storage
    }
    
    static let service = "YonderTrips.auth"
    
    enum TokenType: String {
        case accessToken
        case refreshToken
        
        var key: String {
            return self.rawValue
        }
    }
    
    func save(_ type: TokenType, token: String) throws {
        
        let tokenData = token.data(using: .utf8)!
        
        try storage.create(tokenData, forKey: type.key, service: TokenSecureStorage.service, itemClass: .key)
    }
    
    func fetch(_ type: TokenType) throws -> String {
        
        let tokenData = try storage.read(forKey: type.key, service: TokenSecureStorage.service, itemClass: .key)
        
        guard let token = String(data: tokenData, encoding: .utf8) else {
            throw KeyChainError.invalidData
        }
        
        return token
    }
    
    func update(_ type: TokenType, token: String) throws {
        
        let tokenData = token.data(using: .utf8)!
        
        try storage.update(forKey: type.key, value: tokenData)
    }
    
    func delete(_ type: TokenType) throws {
        
        try storage.delete(forKey: type.key, service: TokenSecureStorage.service, itemClass: .key)
    }
}
