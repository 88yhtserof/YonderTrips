//
//  YonderTripsAuthAPI.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

enum YonderTripsAuthAPI: APIConfiguration, APIErrorConvertible {
    case refresh
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .refresh:
            return HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .refresh:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .refresh:
            return ["accept": "application/json",
                    "RefreshToken": AuthTokenProvider.refresh.token ?? "",
                    "Authorization ": AuthTokenProvider.access.token ?? "",
                    "SeSACKey": YonderTripsAPIProvider.apiKey]
        }
    }
    
    var body: Data? {
        switch self {
        case .refresh:
            return nil
        }
    }
}

private extension YonderTripsAuthAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YonderTripsAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/auth/"
    }
    
    var endPoint: String {
        switch self {
        case .refresh:
            return "refresh"
        }
    }
}
