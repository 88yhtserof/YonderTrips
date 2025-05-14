//
//  LoginResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/11/25.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let userId: String
    let email: String
    let nick: String
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case nick
        case accessToken
        case refreshToken
    }
}
