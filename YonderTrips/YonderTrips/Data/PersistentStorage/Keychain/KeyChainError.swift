//
//  KeyChainError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation

enum KeyChainError: LocalizedError {
    case notFound
    case invalidData
    case alreadyExists
    case failedToCreate
    case authenticationFailed
    case unexpectedDataType
    case unHandledError(status: OSStatus)

    var errorDescription: String? {
        
        switch self {
        case .notFound:
            return "요청한 키체인 항목을 찾을 수 없습니다."
        case .invalidData:
            return "키체인에서 가져온 데이터가 유효하지 않거나 디코딩할 수 없습니다."
        case .alreadyExists:
            return "동일한 키체인 항목이 이미 존재합니다."
        case .failedToCreate:
            return "키체인 항목 생성에 실패했습니다."
        case .authenticationFailed:
            return "Face ID 또는 Touch ID 인증에 실패했습니다."
        case .unexpectedDataType:
            return "예상하지 못한 데이터 타입을 수신했습니다."
        case .unHandledError(let status):
            return "알 수 없는 키체인 오류가 발생했습니다. 상태 코드: \(status)"
        }
    }
}

