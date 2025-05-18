//
//  UserValidationUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import Foundation

struct UserValidationUseCase {
    
    enum ValidationType {
        case email(String)
        case nick(String)
        case password(String)
        
        var message: String {
            switch self {
            case .email:
                return "가입 가능한 이메일입니다."
            case .nick:
                return "사용할 수 있는 닉네임입니다."
            case .password:
                return "사용 가능한 비밀번호입니다."
            }
        }
    }
    
    func validateUserInfo(_ type: ValidationType) throws -> String {
        
        switch type {
            
        case .email(let value):
            guard validateEmail(value) else {
                throw UserValidationError.invalidEmail
            }
        case .nick(let value):
            guard validateNick(value) else {
                throw UserValidationError.invalidNick
            }
            
        case .password(let value):
            guard validatePassword(value) else {
                throw UserValidationError.invalidPassword
            }
        }
        
        return type.message
    }
}

private extension UserValidationUseCase {
    
    func validateEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
    
    func validateNick(_ nick: String) -> Bool {
        let forbiddenCharacters = CharacterSet(charactersIn: ".,?*-@")
        return nick.rangeOfCharacter(from: forbiddenCharacters) == nil && nick.count > 1
    }
    
    func validatePassword(_ password: String) -> Bool {
        let pattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"#
        return password.range(of: pattern, options: .regularExpression) != nil
    }
}
