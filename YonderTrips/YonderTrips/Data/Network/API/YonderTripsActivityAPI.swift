//
//  YonderTripsActivityAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum YonderTripsActivityAPI: APIConfiguration, APIErrorConvertible {
    case new(ActivityCountry, ActivityCategory)
    case detail(String)
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .new, .detail:
            return HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .new(country, category):
            return [URLQueryItem(name: "country", value: country.query),
                    URLQueryItem(name: "category", value: category.query)]
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        var headers = HTTPHeadersProvider.auth
        
        switch self {
        case .detail(let id):
            headers["activity_id"] = id
        default:
            break
        }
        
        return headers
    }
    
    var body: Data? {
        switch self {
        default:
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
        case .detail(let id):
            return id
        }
    }
}
