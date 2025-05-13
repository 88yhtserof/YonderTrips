//
//  UserInfoResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/11/25.
//

import Foundation

struct UserInfoResponseDTO: Decodable {
    let userId: String
    let email: String
    let nick: String
    let profileImage: String?
    let phoneNum: String
    let introduction: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case nick
        case profileImage
        case phoneNum
        case introduction
    }
    
    
}
