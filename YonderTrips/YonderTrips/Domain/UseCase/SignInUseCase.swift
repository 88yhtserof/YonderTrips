//
//  SignInUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import Foundation

struct SignInUseCase {
    
    private let networkService: NetworkService
    private let tokenSecureStorage: TokenSecureRepository
    private let messageTokenRepository: MessageTokenRepository
    
    init(networkService: NetworkService, tokenSecureStorage: TokenSecureRepository, messageTokenRepository: MessageTokenRepository) {
        self.networkService = networkService
        self.tokenSecureStorage = tokenSecureStorage
        self.messageTokenRepository = messageTokenRepository
    }
    
    @discardableResult
    func requestSignInWithEmail(email: String,
                                password: String) async throws -> LoginResponseDTO
    {
        let messageToken = try fetchFCMToken()
        
        let request = EmailLoginRequestDTO(email: email, password: password, deviceToken: messageToken)
        let response: LoginResponseDTO = try await NetworkService.request(apiProvider: .user(.emailLogin(request)))
        
        do {
            try tokenSecureStorage.save(.accessToken, token: response.accessToken)
            try tokenSecureStorage.save(.refreshToken, token: response.refreshToken)
        } catch {
            tokenSecureStorage.rollback()
            throw KeyChainError.failedToCreate(TokenSecureRepository.service)
        }
        
        return response
    }
    
    @discardableResult
    func requestSignInWithKakao(oauthToken: String) async throws -> LoginResponseDTO {
        
        let messageToken = try fetchFCMToken()
        
        let request = KakaoLoginRequestDTO(oauthToken: oauthToken, deviceToken: messageToken)
        let response: LoginResponseDTO = try await NetworkService.request(apiProvider: .user(.kakaoLogin(request)))
        
        do {
            try tokenSecureStorage.save(.accessToken, token: response.accessToken)
            try tokenSecureStorage.save(.refreshToken, token: response.refreshToken)
            
        } catch {
            tokenSecureStorage.rollback()
            throw KeyChainError.failedToCreate(TokenSecureRepository.service)
        }
        
        return response
    }
    
    @discardableResult
    func requestSignInWithApple(idToken: String, nick: String) async throws -> LoginResponseDTO {
        
        let messageToken = try fetchFCMToken()
        
        let request = AppleLoginRequestDTO(idToken: idToken, deviceToken: messageToken, nick: nick)
        let response: LoginResponseDTO = try await NetworkService.request(apiProvider: .user(.appleLogin(request)))
        
        do {
            try tokenSecureStorage.save(.accessToken, token: response.accessToken)
            try tokenSecureStorage.save(.refreshToken, token: response.refreshToken)
            
        } catch {
            tokenSecureStorage.rollback()
            throw KeyChainError.failedToCreate(TokenSecureRepository.service)
        }
        
        return response
    }
}

private extension SignInUseCase {
    
    func fetchFCMToken() throws -> String {
        
        do {
            return try messageTokenRepository.fetch(.fcmToken)
        } catch {
            YonderTripsLogger.shared.debug("Failed to fetch device token.")
            throw KeyChainError.notFound("디바이스 토큰을 찾을 수 없습니다.")
        }
    }
}
