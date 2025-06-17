//
//  YTAPIProvider.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/9/25.
//

import Foundation

enum YTAPIProvider {
    case auth(YTAuthAPI)
    case user(YTUserAPI)
    case activity(YTActivityAPI)
    case activityPost(YTActivityPostAPI)
    case order(YTOrderAPI)
    
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
        case .order(let api):
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
