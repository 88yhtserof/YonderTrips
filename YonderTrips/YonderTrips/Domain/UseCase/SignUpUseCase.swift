//
//  SignUpUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/18/25.
//

import Foundation

struct SignUpUseCase {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
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
        
        let response: JoinResponseDTO = try await networkService.request(apiConfiguration: YonderTripsUserAPI.join(request))
        return response
    }
}
