//
//  UserValidationUseCaseType.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import Foundation

protocol UserValidationUseCaseType {
    
    @discardableResult
    func validateUserInfo(_ type: UserValidationUseCase.ValidationType) throws -> String
}
