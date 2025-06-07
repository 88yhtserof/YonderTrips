//
//  YonderTripsAPIProvider.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/9/25.
//

import Foundation

enum YonderTripsAPIProvider {
    case auth(YonderTripsAuthAPI)
    case user(YonderTripsUserAPI)
    case activity(YonderTripsActivityAPI)
    case activityPost(YonderTripsActivityPostAPI)
    
    var api: APIConfiguration & APIErrorConvertible {
        switch self {
        case .auth(let api):
            return api
        case .user(let api):
            return api
        case .activity(let api):
            return api
        case .activityPost(let api):
            return api
        }
    }
    
    static var baseURL: String {
        AuthorizationProvider.yonderTrips.url ?? ""
    }
    
    static var apiKey: String {
        AuthorizationProvider.yonderTrips.apiKey ?? ""
    }
}
