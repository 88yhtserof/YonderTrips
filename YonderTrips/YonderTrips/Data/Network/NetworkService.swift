//
//  NetworkService.swift
//  YonderTrips-Practice
//
//  Created by 임윤휘 on 5/9/25.
//

import SwiftUI

struct NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T, Config>(apiConfiguration api: Config) async throws -> T where T : Decodable, Config : APIConfiguration & APIErrorConvertible {
        
        guard let url = api.url else {
            
            let error = ClientError.invalidURL(api.url?.absoluteString)
            YonderTripsLogger.shared.error(error)
            throw error
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = api.method
        request.allHTTPHeaderFields = api.headers
        request.httpBody = api.body
        
        var data: Data
        var response: URLResponse
        
        do {
            let result = try await URLSession.shared.data(for: request)
            (data, response) = (result.0, result.1)
            
        } catch {
            let error = ClientError.requestCreationFailed(error)
            YonderTripsLogger.shared.error(error)
            throw error
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            
            let error = ClientError.missingResponseData
            YonderTripsLogger.shared.error(error)
            throw error
        }
        
        guard (200..<300) ~= httpResponse.statusCode else {
            let error = api.error(data, statusCode: httpResponse.statusCode)
            YonderTripsLogger.shared.error(error)
            throw error
        }
        YonderTripsLogger.shared.debug("Success: request \(api)")
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            let error = ClientError.failedDecoding(error)
            YonderTripsLogger.shared.error(error)
            throw error
        }
    }
    
}

extension NetworkService: EnvironmentKey {
    
    static let defaultValue: NetworkService = {
        return NetworkService()
    }()
}

extension EnvironmentValues {
    
    var networkService: NetworkService {
        get { self[NetworkService.self] }
        set { self[NetworkService.self] = newValue }
    }
}

