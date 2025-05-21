//
//  SignInUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import Foundation

struct SignInUseCase {
    
    private let networkService: NetworkService
    private let tokenSecureStorage: TokenSecureStorage
    
    init(networkService: NetworkService, tokenSecureStorage: TokenSecureStorage) {
        self.networkService = networkService
        self.tokenSecureStorage = tokenSecureStorage
    }
    
    @discardableResult
    func requestSignInWithEmail(email: String,
                                password: String) async throws -> LoginResponseDTO
    {
        let request = EmailLoginRequestDTO(email: email, password: password, deviceToken: "")
        let response: LoginResponseDTO = try await networkService.request(apiConfiguration: YonderTripsUserAPI.emailLogin(request))
        
        do {
            try tokenSecureStorage.save(.accessToken, token: response.accessToken)
            try tokenSecureStorage.save(.refreshToken, token: response.refreshToken)
            
        } catch {
            tokenSecureStorage.rollback()
            throw KeyChainError.failedToCreate(TokenSecureStorage.service)
        }
        
        return response
    }
}
