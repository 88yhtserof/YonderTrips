//
//  PaymentValidationRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct PaymentValidationRequestDTO: Codable {
    let impUid: String
    
    enum CodingKeys: String, CodingKey {
        case impUid = "imp_uid"
    }
}

extension PaymentValidationRequestDTO {
    
    func toEntity() -> PaymentValidation {
        return PaymentValidation(impUid: impUid)
    }
}
