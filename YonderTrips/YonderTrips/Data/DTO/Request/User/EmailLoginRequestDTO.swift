//
//  EmailLoginRequestDTO.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

struct EmailLoginRequestDTO: Encodable {
    let email: String
    let password: String
    let deviceToken: String

    enum CodingKeys: String, CodingKey {
        case email
        case password
        case deviceToken
    }
}

