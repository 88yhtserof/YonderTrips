//
//  APIConfiguration.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/9/25.
//

import Foundation

protocol APIConfiguration {
    
    var url: URL? { get }
    var method: String { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}
