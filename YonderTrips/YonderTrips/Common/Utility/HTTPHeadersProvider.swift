//
//  HTTPHeadersProvider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/2/25.
//

import Foundation

struct HTTPHeadersProvider {
    
    static let apiKey = ["accept": "application/json",
                         "SeSACKey": YonderTripsAPIProvider.apiKey]
    
    static let refresh = ["accept": "application/json",
                          "RefreshToken": AuthTokenProvider.refresh.token ?? "",
                          "Authorization": AuthTokenProvider.access.token ?? "",
                          "SeSACKey": YonderTripsAPIProvider.apiKey]
    
    static let auth = ["accept": "application/json",
                       "Authorization": AuthTokenProvider.access.token ?? "",
                       "SeSACKey": YonderTripsAPIProvider.apiKey]
}
