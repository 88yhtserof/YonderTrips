//
//  KakaoLoginRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

struct KakaoLoginRequestDTO: Encodable {
    let oauthToken: String
    let deviceToken: String

    enum CodingKeys: String, CodingKey {
        case oauthToken
        case deviceToken
    }
}
