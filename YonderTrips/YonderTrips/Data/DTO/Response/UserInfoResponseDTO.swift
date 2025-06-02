//
//  UserInfoResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/11/25.
//

import Foundation

struct UserInfoResponseDTO: Decodable {
    let userId: String
    let nick: String
    let profileImage: String
    let introduction: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case nick
        case profileImage
        case introduction
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? ""
        self.introduction = try container.decode(String.self, forKey: .introduction)
    }
}

extension UserInfoResponseDTO {
    
    func toEntity() -> UserInfo {
        UserInfo(
            userId: userId,
            nick: nick,
            profileImage: profileImage,
            introduction: introduction
        )
    }
}
