//
//  YTBannerAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/30/25.
//

import Foundation

enum YTBannerAPI: APIConfiguration, APIErrorConvertible {
    case getBanners
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .getBanners:
            HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default: return nil
        }
    }
    
    var headers: [String : String]? {
        
        var headers = HTTPHeadersProvider.auth
        
        switch self {
        default:
            return headers
        }
    }
    
    var body: Data? {
        switch self {
        default:
            return nil
        }
    }
}

private extension YTBannerAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YTAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/banners/"
    }
    
    var endPoint: String {
        switch self {
        case .getBanners:
            return "main"
        }
    }
}
