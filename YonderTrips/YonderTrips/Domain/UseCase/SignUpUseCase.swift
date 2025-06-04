//
//  SignUpUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/18/25.
//

import Foundation

struct SignUpUseCase: SignUpUseCaseType {
    
    private let networkService: NetworkService
    private let tokenSecureStorage: TokenSecureStorage
    
    init(networkService: NetworkService, tokenSecureStorage: TokenSecureStorage) {
        self.networkService = networkService
        self.tokenSecureStorage = tokenSecureStorage
    }
    
    @discardableResult
    func requestSignUp(email: String,
                       password: String,
                       nick: String,
                       phoneNum: String,
                       introduction: String) async throws -> JoinResponseDTO
    {
        let request = JoinRequestDTO(email: email,
                                     password: password,
                                     nick: nick,
                                     phoneNum: phoneNum,
                                     introduction: introduction,
                                     deviceToken: "") // TODO: - 디바이스토큰 fetch 로직 추가
        
        let response: JoinResponseDTO = try await NetworkService.request(apiProvider: .user(.join(request)))
        
        do {
            try tokenSecureStorage.save(.accessToken, token: response.accessToken)
            try tokenSecureStorage.save(.refreshToken, token: response.refreshToken)
            
        } catch {
            tokenSecureStorage.rollback()
            throw KeyChainError.failedToCreate(TokenSecureStorage.service)
        }
        
        return response
    }
    
    func requestEmailValidation(email: String) async throws -> EmailValidationResponseDTO {
        
        let request = EmailValidationRequestDTO(email: email)
        
        let reponse: EmailValidationResponseDTO = try await NetworkService.request(apiProvider: .user(.emailValidation(request)))
        
        return reponse
    }
}
