//
//  AppleLoginRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

struct AppleLoginRequestDTO: Encodable {
    let idToken: String
    let deviceToken: String
    let nick: String

    enum CodingKeys: String, CodingKey {
        case idToken
        case deviceToken
        case nick
    }
}
