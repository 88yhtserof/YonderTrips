//
//  YonderTripsDataAPI.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/2/25.
//

import Foundation

enum YonderTripsDataAPI {
    case data(String)
    
    var url: URL? {
        return URL(string: YonderTripsAPIProvider.baseURL + endPoint)
    }
}

private extension YonderTripsDataAPI {
    
    var endPoint: String {
        switch self {
        case .data(let path):
            return "/v1/" + path
        }
    }
}
