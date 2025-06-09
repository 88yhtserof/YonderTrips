//
//  AuthNetworkError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/9/25.
//

import Foundation

enum AuthNetworkError: Error {
    case accessTokenExpired
    case refreshTokenExpired
}
