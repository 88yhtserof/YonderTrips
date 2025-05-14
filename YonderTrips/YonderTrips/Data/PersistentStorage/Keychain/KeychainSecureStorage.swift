//
//  KeychainRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation
import Security

struct KeychainSecureStorage {

    enum KeychainItemClass {
        case genericPassword
        case internetPassword
        case certificate
        case key
        case identity

        var secValue: CFString {
            switch self {
            case .genericPassword:
                return kSecClassGenericPassword
            case .internetPassword:
                return kSecClassInternetPassword
            case .certificate:
                return kSecClassCertificate
            case .key:
                return kSecClassKey
            case .identity:
                return kSecClassIdentity
            }
        }
    }

    func create(_ data: Data,
              forKey key: String,
              service: String,
              itemClass: KeychainItemClass) throws
    {
        let query: [String: Any] = [
            kSecClass as String           : itemClass,
            kSecAttrAccount as String     : key,
            kSecAttrService as String     : service,
            kSecValueData as String       : data
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            YonderTripsLogger.shared.debug("Success: item saved to keychain")
            
        case errSecDuplicateItem:
            let error = KeyChainError.alreadyExists
            YonderTripsLogger.shared.error(error)
            throw error
            
        default:
            let error = KeyChainError.failedToCreate
            YonderTripsLogger.shared.error(error)
            throw error
        }
    }
    
    func read(forKey key: String,
              service: String,
              itemClass: KeychainItemClass) throws -> Data
    {
        let query: [String: Any] = [
            kSecClass as String           : itemClass,
            kSecAttrAccount as String     : key,
            kSecAttrService as String     : service,
            kSecReturnData as String      : kCFBooleanTrue!,
            kSecMatchLimit as String      : kSecMatchLimitOne
        ]
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
            let error = KeyChainError.notFound
            YonderTripsLogger.shared.error(error)
            throw error
        }
        
        guard status == errSecSuccess else {
            let error = KeyChainError.unHandledError(status: status)
            YonderTripsLogger.shared.error(error)
            throw error
        }
        
        guard let resultItem = result as? [String: Any],
              let data = resultItem[kSecValueData as String] as? Data else {
            let error = KeyChainError.invalidData
            YonderTripsLogger.shared.error(error)
            throw error
        }
        
        return data
    }
    
    func update(forKey key: String, value: Data) throws {
        
        let existingQuery: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrAccount: key
        ]
        
        let updateQuery: [CFString: Any] = [
            kSecValueData: value
        ]
        
        let status = SecItemUpdate(existingQuery as CFDictionary,
                                   updateQuery as CFDictionary)
        
        if status == errSecSuccess {
            YonderTripsLogger.shared.debug("Success: item updated to keychain")
        } else {
            let error = KeyChainError.unHandledError(status: status)
            YonderTripsLogger.shared.error(error)
            throw error
        }
    }
    
    func delete(forKey key: String,
                service: String,
                itemClass: KeychainItemClass) throws
    {
        let query: [String: Any] = [
            kSecClass as String           : itemClass,
            kSecAttrAccount as String     : key,
            kSecAttrService as String     : service
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status == errSecSuccess,
           status == errSecItemNotFound {
            YonderTripsLogger.shared.debug("Success: item saved to keychain")
            
        } else {
            let error = KeyChainError.unHandledError(status: status)
            YonderTripsLogger.shared.error(error)
            throw error
        }
    }
}
