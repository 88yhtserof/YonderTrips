//
//  DIContainer.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/19/25.
//

import Foundation

struct DIContainer {
    
    private let logger: YonderTripsLogger
    private let networkService: NetworkService
    
    private let keychainSecureStorage: KeychainSecureStorage
    private let tokenSecureStorage: TokenSecureStorage
    
    private let userInfoValidationUseCase: UserValidationUseCase
    
    init() {
        
        self.logger = YonderTripsLogger.shared
        self.networkService = NetworkService(logger: logger)
        
        self.keychainSecureStorage = KeychainSecureStorage()
        self.tokenSecureStorage = TokenSecureStorage(storage: keychainSecureStorage)
        
        self.userInfoValidationUseCase = UserValidationUseCase()
    }
}

// ViewModel Factory
extension DIContainer {
    
    func makeSignUpViewModel() -> SignUpViewModel {
        
        let signUpUseCase = SignUpUseCase(networkService: networkService, tokenSecureStorage: tokenSecureStorage)
        return SignUpViewModel(userInfoValidationUseCase: userInfoValidationUseCase, signUpUseCase: signUpUseCase)
    }
}
