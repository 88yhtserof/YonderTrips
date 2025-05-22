//
//  DIContainer.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/19/25.
//

import SwiftUI

struct DIContainer {
    
    private let networkService: NetworkService
    
    private let keychainSecureStorage: KeychainSecureStorage
    private let tokenSecureStorage: TokenSecureStorage
    
    private let userInfoValidationUseCase: UserValidationUseCase
    
    init() {
        self.networkService = NetworkService()
        
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
    
    func makeSignInViewModel() -> SignInViewModel {
        
        let signInUseCase = SignInUseCase(networkService: networkService, tokenSecureStorage: tokenSecureStorage)
        return SignInViewModel(signInUseCase: signInUseCase)
    }
    
    func makeEmailSignInViewModel() -> EmailSignInViewModel {
        
        let signInUseCase = SignInUseCase(networkService: networkService, tokenSecureStorage: tokenSecureStorage)
        return EmailSignInViewModel(signInUseCase: signInUseCase)
    }
}

// Environment
extension DIContainer: EnvironmentKey {
    
    static let defaultValue: DIContainer = {
        return DIContainer()
    }()
}

extension EnvironmentValues {
    
    var container: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}
