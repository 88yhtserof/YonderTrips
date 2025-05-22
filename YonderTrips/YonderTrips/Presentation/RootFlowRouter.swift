//
//  RootFlowRouter.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/20/25.
//

import SwiftUI

@MainActor
final class RootFlowRouter: ObservableObject {
    
    @Published var rootFlow: RootFlow = .signIn
    
    enum RootFlow: Hashable {
        case signIn
        case signUp
        case home
    }
}
