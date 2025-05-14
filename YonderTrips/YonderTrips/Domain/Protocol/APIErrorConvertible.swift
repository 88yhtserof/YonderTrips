//
//  APIErrorConvertible.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/10/25.
//

import Foundation

protocol APIErrorConvertible {
    
    // Return the error with the error description.
    func error(_ data: Data, statusCode: Int) -> LocalizedError
}

extension APIErrorConvertible {
    
    func error(_ data: Data, statusCode: Int) -> LocalizedError {
        
        do {
            let response = try JSONDecoder().decode(ErrorResponseDTO.self, from: data)
            return YonderTripsNetworkError(statusCode: statusCode, message: response.message)
            
        } catch {
            return ClientError.failedDecoding(error)
        }
    }
}
