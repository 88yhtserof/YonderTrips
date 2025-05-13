//
//  RefreshTokenResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/11/25.
//

import Foundation

struct RefreshTokenResponseDTO: Decodable {
    
    let accessToken: String
    let refreshToken: String
}
