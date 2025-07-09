//
//  YTChatAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

enum YTChatAPI: APIConfiguration, APIErrorConvertible {
    case createChat(CreateChatRequestDTO)
    case getChatList
    case sendChatMessage(String, ChatMessageRequestDTO)
    case getChatMessageList(String, String)
    
    var url: URL? {
        return urlComponents.url
    }
    
    var method: String {
        switch self {
        case .getChatList, .getChatMessageList:
            return HTTPMethod.get
        case .createChat, .sendChatMessage:
            return HTTPMethod.post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .getChatMessageList(_, next):
            return [URLQueryItem(name: "next", value: next)]
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        return HTTPHeadersProvider.auth
    }
    
    var body: Data? {
        do {
            switch self {
            case .createChat(let request):
                return try JSONEncoder().encode(request)
            case let .sendChatMessage(_, request):
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

private extension YTChatAPI {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: YTAPIProvider.baseURL)
        components?.path = path + endPoint
        components?.queryItems = parameters
        return components ?? URLComponents()
    }
    
    var path: String {
        return "/v1/chats/"
    }
    
    var endPoint: String {
        switch self {
        case let .sendChatMessage(roomId, _):
            return roomId
        case .getChatMessageList(let roomId, _):
            return roomId
        default:
            return ""
        }
    }
}
