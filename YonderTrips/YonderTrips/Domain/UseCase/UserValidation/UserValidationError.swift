//
//  UserValidationError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import Foundation

enum UserValidationError: Error, LocalizedError {
    case invalidEmail
    case invalidNick
    case invalidPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "유효하지 않은 이메일 형식입니다. 올바른 이메일 주소를 입력해주세요."
        case .invalidNick:
            return "닉네임은 두 글자 이상이어야 하며, 특수문자(. , ? * - @)를 포함할 수 없습니다."
        case .invalidPassword:
            return "비밀번호는 최소 8자 이상이어야 하며, 영문자, 숫자, 특수문자(@$!%*#?&)를 각각 최소 1개 이상 포함해야 합니다."
        }
    }
}
