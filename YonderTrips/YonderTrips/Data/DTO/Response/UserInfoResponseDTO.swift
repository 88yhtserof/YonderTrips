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
    let profileImage: String
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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decode(String.self, forKey: .email)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
        self.phoneNum = try container.decode(String.self, forKey: .phoneNum)
        self.introduction = try container.decode(String.self, forKey: .introduction)
    }
}

extension UserInfoResponseDTO {
    
    func toEntity() -> UserInfo {
        UserInfo(
            userId: userId,
            email: email,
            nick: nick,
            profileImage: profileImage,
            phoneNum: phoneNum,
            introduction: introduction
        )
    }
}
