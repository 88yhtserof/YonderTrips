//
//  YonderTripsNetworkError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/9/25.
//

import Foundation

struct YonderTripsNetworkError: LocalizedError {
    
    let statusCode: Int
    let message: String
    

    var errorDescription: String? {
        return "\(statusCode): \(message)"
    }
}
