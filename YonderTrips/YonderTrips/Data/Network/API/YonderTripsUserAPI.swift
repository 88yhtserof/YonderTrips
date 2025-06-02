//
//  YonderTripsUserAPI.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

enum YonderTripsUserAPI: APIConfiguration, APIErrorConvertible {
    case emailValidation(EmailValidationRequestDTO)
    case join(JoinRequestDTO)
    case emailLogin(EmailLoginRequestDTO)
    case kakaoLogin(KakaoLoginRequestDTO)
    case appleLogin(AppleLoginRequestDTO)
    case profileFetch
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .emailValidation, .join, .emailLogin, .kakaoLogin, .appleLogin:
            return HTTPMethod.post
        case .profileFetch:
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
        var headers = HTTPHeadersProvider.apiKey
        
        switch self {
        case .profileFetch:
            return HTTPHeadersProvider.auth
        default:
            headers["Content-Type"] = "application/json"
        }
        
        return headers
    }
    
    var body: Data? {
        do {
            switch self {
            case .emailValidation(let request):
                return try JSONEncoder().encode(request)
            case .join(let request):
                return try JSONEncoder().encode(request)
            case .emailLogin(let request):
                return try JSONEncoder().encode(request)
            case .kakaoLogin(let request):
                return try JSONEncoder().encode(request)
            case .appleLogin(let request):
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

private extension YonderTripsUserAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YonderTripsAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/users/"
    }
    
    var endPoint: String {
        switch self {
        case .emailValidation:
            return "validation/email"
        case .join:
            return "join"
        case .emailLogin:
            return "login"
        case .kakaoLogin:
            return "login/kakao"
        case .appleLogin:
            return "login/apple"
        case .profileFetch:
            return "me/profile"
        }
    }
}
