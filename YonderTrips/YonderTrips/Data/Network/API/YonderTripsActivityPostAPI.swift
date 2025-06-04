//
//  YonderTripsActivityPostAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/4/25.
//

import Foundation

enum YonderTripsActivityPostAPI: APIConfiguration, APIErrorConvertible {
    case geolocation(country: String?,
                     category: String?,
                     longitude: Double?,
                     latitude: Double?,
                     maxDistance: Double?,
                     next: String = "",
                     order_by: OrderBy = .createdAt)
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .geolocation:
            HTTPMethod.get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .geolocation(country, category, longitude, latitude, maxDistance, next, order_by):
            configureGeolocationParameter(self)
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

private extension YonderTripsActivityPostAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YonderTripsAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/posts/"
    }
    
    var endPoint: String {
        switch self {
        case .geolocation:
            return "geolocation"
        }
    }
}

//MARK: - Type
extension YonderTripsActivityPostAPI {
    
    enum OrderBy: String {
        case createdAt
        case likes
        
        var query: String {
            return rawValue
        }
    }
}

//MARK: - Configuring Queries
private extension YonderTripsActivityPostAPI {
    
    func configureGeolocationParameter(_ api: YonderTripsActivityPostAPI) -> [URLQueryItem] {
        switch self {
        case let .geolocation(country, category, longitude, latitude, maxDistance, next, order_by):
            
            var queries: [URLQueryItem] = []
            
            if let country {
                queries.append(URLQueryItem(name: "country", value: country))
            }
            
            if let category {
                queries.append(URLQueryItem(name: "category", value: category))
            }
            
            if let longitude, let latitude {
                [URLQueryItem(name: "longitude", value: "\(longitude)"),
                 URLQueryItem(name: "latitude", value: "\(latitude)")]
                    .forEach{ queries.append($0) }
            }
            
            if let maxDistance {
                queries.append(URLQueryItem(name: "maxDistance", value: "\(maxDistance)"))
            }
            
            [URLQueryItem(name: "next", value: next),
             URLQueryItem(name: "order_by", value: order_by.query)]
                .forEach{ queries.append($0) }
            
            return queries
        }
    }
}
