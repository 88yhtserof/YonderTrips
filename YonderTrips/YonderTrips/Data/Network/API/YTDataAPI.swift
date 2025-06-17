//
//  YTDataAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/2/25.
//

import Foundation

enum YTDataAPI {
    case data(String)
    
    var url: URL? {
        return URL(string: YTAPIProvider.baseURL + endPoint)
    }
}

private extension YTDataAPI {
    
    var endPoint: String {
        switch self {
        case .data(let path):
            return "/v1" + path
        }
    }
}
