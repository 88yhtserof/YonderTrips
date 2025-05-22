//
//  SignUpUseCaseType.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import Foundation

protocol SignUpUseCaseType {
    
    @discardableResult
    func requestSignUp(email: String,
                       password: String,
                       nick: String,
                       phoneNum: String,
                       introduction: String) async throws -> JoinResponseDTO
    
    func requestEmailValidation(email: String) async throws -> EmailValidationResponseDTO
}
