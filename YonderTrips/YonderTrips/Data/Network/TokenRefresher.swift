//
//  TokenRefresher.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/30/25.
//

import Foundation

actor TokenRefresher {
    
    static let shared = TokenRefresher()
    
    private init(){ }
    
    private let tokenSecureStorage = TokenSecureRepository()
    
    private var isRefreshing = false
    private var waitingContinuations: [CheckedContinuation<Void, Error>] = []
    
    func refreshIfNeeded() async throws {
        YonderTripsLogger.shared.debug("\(self) -> start refreshing token")
        
        if isRefreshing {
            return try await withCheckedThrowingContinuation { continuation in
                waitingContinuations.append(continuation)
            }
        }
        
        isRefreshing = true
        defer { isRefreshing = false }
        
        do {
            let tokenResponse = try await requestRefresh()
            try tokenSecureStorage.saveAuthToken(with: tokenResponse)
            resumeContinuations()
        } catch {
            resumeContinuations(with: error)
            throw error
        }
    }
    
    private func resumeContinuations(with error: Error? = nil) {
        for continuation in waitingContinuations {
            if let error = error {
                continuation.resume(throwing: error)
            } else {
                continuation.resume()
            }
        }
        waitingContinuations.removeAll()
    }
    
    private func requestRefresh() async throws -> RefreshTokenResponseDTO {
        
        do {
            let response: RefreshTokenResponseDTO = try await NetworkService.request(apiProvider: .auth(.refresh))
            return response
        } catch let error as YonderTripsNetworkError where error.statusCode == 418 {
            throw AuthNetworkError.refreshTokenExpired
        } catch {
            throw error
        }
    }
}
