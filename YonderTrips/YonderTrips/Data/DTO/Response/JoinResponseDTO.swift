//
//  JoinResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/10/25.
//


struct JoinResponseDTO: Codable {
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
