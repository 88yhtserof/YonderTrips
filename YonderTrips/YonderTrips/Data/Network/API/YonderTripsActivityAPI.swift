//
//  YonderTripsActivityAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum YonderTripsActivityAPI: APIConfiguration, APIErrorConvertible {
    case new(ActivityCountry, ActivityCategory)
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .new:
            return HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .new(country, category):
            return [URLQueryItem(name: "country", value: country.title),
                    URLQueryItem(name: "category", value: category.title)]
        }
    }
    
    var headers: [String : String]? {
        
        var headers = ["accept": "application/json",
                       "Authorization ": AuthTokenProvider.access.token ?? "",
                       "SeSACKey": YonderTripsAPIProvider.apiKey]
        
        switch self {
        case .new:
            return headers
        }
    }
    
    var body: Data? {
        switch self {
        case .new:
            return nil
        }
    }
}

private extension YonderTripsActivityAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YonderTripsAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/activities/"
    }
    
    var endPoint: String {
        switch self {
        case .new:
            return "new"
        }
    }
}
