//
//  PaymentError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/17/25.
//

import Foundation

enum PaymentError: LocalizedError  {
    case missingRequiredValues          // 400 - 필수값을 채워주세요.
    case invalidPayment                 // 400 - 유효하지 않은 결제건입니다.
    case orderNotFound                  // 404 - 주문번호를 다시 확인해주세요.
    case timeAlreadyReserved            // 409 - 이미 예약된 시간입니다.
    case accountMismatch                // 445 - 계정이 주문자와 일치하지 않습니다.
    case unknownError(code: Int)        // 예외 처리용

    init(_ statuseCode: Int, _ message: String) {
        switch statuseCode {
        case 400:
            self = message == PaymentError.missingRequiredValues.errorDescription ? .missingRequiredValues : .invalidPayment
        case 404:
            self = .orderNotFound
        case 409:
            self = .timeAlreadyReserved
        case 445:
            self = .accountMismatch
        default:
            self = .unknownError(code: statuseCode)
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .missingRequiredValues:
            return "필수값을 채워주세요."
        case .invalidPayment:
            return "유효하지 않은 결제건입니다."
        case .orderNotFound:
            return "주문번호를 다시 확인해주세요."
        case .timeAlreadyReserved:
            return "이미 예약된 시간입니다."
        case .accountMismatch:
            return "계정이 주문자와 일치하지 않습니다."
        case .unknownError(let code):
            return "알 수 없는 오류가 발생했습니다. (코드: \(code))"
        }
    }
}
