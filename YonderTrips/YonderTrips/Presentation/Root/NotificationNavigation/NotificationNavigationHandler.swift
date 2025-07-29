//
//  NotificationNavigationHandler.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/29/25.
//

import SwiftUI

struct NotificationNavigationHandler: ViewModifier {
    @ObservedObject private var navigationManager = NotificationNavigationManager.shared
    @EnvironmentObject private var rootRouter: RootFlowRouter
    @EnvironmentObject private var homeRouter: HomeFlowRouter
    
    func body(content: Content) -> some View {
        content
            .onReceive(navigationManager.$pendingNavigation) { navigation in
                guard let navigation = navigation else { return }
                
                handleNavigation(navigation)
                navigationManager.clearPendingNavigation()
            }
    }
    
    private func handleNavigation(_ navigation: NotificationNavigationManager.PendingNavigation) {
        rootRouter.rootFlow = .home
        
        Task {
            try await Task.sleep(for: .seconds(0.5))
            
            switch navigation {
            case .chatRoomList:
                homeRouter.path.append(HomeFlowRouter.HomeFlow.chatRoomList)
            }
        }
    }
}

extension View {
    func handleNotificationNavigation() -> some View {
        self.modifier(NotificationNavigationHandler())
    }
}
