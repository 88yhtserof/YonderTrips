//
//  TokenRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/26/25.
//

import Foundation

protocol TokenRepository {
    associatedtype TokenType: RawRepresentable where TokenType.RawValue == String
    static var service: String { get }
    var storage: KeychainSecureStorage { get }
    
    func save(_ type: TokenType, token: String) throws
    func fetch(_ type: TokenType) throws -> String
    func update(_ type: TokenType, token: String) throws
    func delete(_ type: TokenType) throws
}

/// CRUD method
extension TokenRepository {
    
    var storage: KeychainSecureStorage { .shared }
    
    func save(_ type: TokenType, token: String) throws {
        guard let tokenData = token.data(using: .utf8) else {
            throw KeyChainError.invalidData
        }
        try storage.create(tokenData, forKey: type.rawValue, service: Self.service, itemClass: .genericPassword)
    }
    
    func fetch(_ type: TokenType) throws -> String {
        let tokenData = try storage.read(forKey: type.rawValue, service: Self.service, itemClass: .genericPassword)
        guard let token = String(data: tokenData, encoding: .utf8) else {
            throw KeyChainError.invalidData
        }
        return token
    }
    
    func update(_ type: TokenType, token: String) throws {
        guard let tokenData = token.data(using: .utf8) else {
            throw KeyChainError.invalidData
        }
        try storage.update(forKey: type.rawValue, value: tokenData, itemClass: .genericPassword)
    }
    
    func delete(_ type: TokenType) throws {
        try storage.delete(forKey: type.rawValue, service: Self.service, itemClass: .genericPassword)
    }
}
