//
//  HTTPHeadersProvider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/2/25.
//

import Foundation

struct HTTPHeadersProvider {
    
    static var apiKey: [String: String] {
        ["accept": "application/json",
         "SeSACKey": YonderTripsAPIProvider.apiKey]
    }
    
    static var refresh: [String: String] {
        ["accept": "application/json",
         "RefreshToken": AuthTokenProvider.refresh.token ?? "",
         "Authorization": AuthTokenProvider.access.token ?? "",
         "SeSACKey": YonderTripsAPIProvider.apiKey]
    }
    
    static var auth: [String: String] {
        ["accept": "application/json",
         "Authorization": AuthTokenProvider.access.token ?? "",
         "SeSACKey": YonderTripsAPIProvider.apiKey]
    }
}
