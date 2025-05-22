//
//  SignInFlowRouter.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

final class SignInFlowRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    enum SignInFlow: Hashable {
        case emailSignIn
        case signUp
    }
}
