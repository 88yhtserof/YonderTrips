//
//  YTActivityAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

enum YTActivityAPI: APIConfiguration, APIErrorConvertible {
    case new(ActivityCountry, ActivityCategory)
    case detail(String)
    case activities(ActivityCountry, ActivityCategory, String)
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .new, .detail, .activities:
            return HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .new(country, category):
            return [URLQueryItem(name: "country", value: country.query),
                    URLQueryItem(name: "category", value: category.query)]
        case let .activities(country, category, id):
            return [URLQueryItem(name: "country", value: country.query),
                    URLQueryItem(name: "category", value: category.query),
                    URLQueryItem(name: "next", value: id),
                    URLQueryItem(name: "limit", value: "8")]
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

private extension YTActivityAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YTAPIProvider.baseURL)
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
        case .activities:
            return ""
        }
    }
}
