//
//  YTOrderAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

enum YTOrderAPI: APIConfiguration, APIErrorConvertible {
    case orderCreate(OrderRequestDTO)
    case orderList
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .orderCreate:
            return HTTPMethod.post
        case .orderList:
            return HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        var headers = HTTPHeadersProvider.auth
        
        switch self {
        case .orderCreate:
            headers["Content-Type"] = "application/json"
        default:
            return headers
        }
        
        return headers
    }
    
    var body: Data? {
        do {
            switch self {
            case .orderCreate(let request):
                return try JSONEncoder().encode(request)
            default:
                return nil
            }
            
        } catch {
            let error = ClientError.failedEncoding(error)
            YonderTripsLogger.shared.error(error)
            return nil
        }
    }
}

private extension YTOrderAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YTAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/orders"
    }
    
    var endPoint: String {
        switch self {
        default:
            return ""
        }
    }
}
