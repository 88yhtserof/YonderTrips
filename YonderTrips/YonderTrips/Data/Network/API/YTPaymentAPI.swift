//
//  YTPaymentAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/17/25.
//

import Foundation

enum YTPaymentAPI: APIConfiguration, APIErrorConvertible {
    case validation(PaymentValidationRequestDTO)
    case paymentReceipt(String)
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .validation:
            return HTTPMethod.post
        case .paymentReceipt:
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
        case .validation:
            headers["Content-Type"] = "application/json"
        default:
            return headers
        }
        
        return headers
    }
    
    var body: Data? {
        do {
            switch self {
            case .validation(let request):
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

private extension YTPaymentAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YTAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/payments/"
    }
    
    var endPoint: String {
        switch self {
        case .validation:
            return "validation"
        case .paymentReceipt(let orderCode):
            return "\(orderCode)"
        }
    }
}
