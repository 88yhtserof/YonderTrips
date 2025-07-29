//
//  NotificationNavigationManager.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/29/25.
//

import SwiftUI
import Combine

final class NotificationNavigationManager: ObservableObject {
    static let shared = NotificationNavigationManager()
    
    @Published var pendingNavigation: PendingNavigation?
    
    private init() {}
    
    enum PendingNavigation {
        case chatRoomList
    }
    
    func navigateToChatRoomList() {
        pendingNavigation = .chatRoomList
    }
    
    func clearPendingNavigation() {
        pendingNavigation = nil
    }
}


