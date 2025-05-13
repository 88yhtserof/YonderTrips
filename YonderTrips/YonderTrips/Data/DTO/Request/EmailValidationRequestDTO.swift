//
//  EmailValidationRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

struct EmailValidationRequestDTO: Encodable {
    
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case email
    }
}


