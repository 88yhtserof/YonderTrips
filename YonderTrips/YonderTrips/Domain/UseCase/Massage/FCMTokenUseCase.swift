//
//  FCMTokenUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/26/25.
//

import Foundation

final class FCMTokenUseCase {
    
    private let repository: MessageTokenRepository
    
    init(repository: MessageTokenRepository) {
        self.repository = repository
    }
    
    func save(token: String) {
        do {
            try repository.save(.fcmToken, token: token)
            
        } catch {
            YonderTripsLogger.shared.debug("Failed to save FCM token: \(error)")
        }
    }
    
    func fetch() -> String? {
        do {
            return try repository.fetch(.fcmToken)
        } catch {
            YonderTripsLogger.shared.debug("Failed to fetch FCM token: \(error)")
            return nil
        }
    }
}
