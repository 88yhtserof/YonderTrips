//
//  JoinRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

struct JoinRequestDTO: Encodable {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String
    let introduction: String
    let deviceToken: String

    enum CodingKeys: String, CodingKey {
        case email
        case password
        case nick
        case phoneNum
        case introduction
        case deviceToken
    }
}
