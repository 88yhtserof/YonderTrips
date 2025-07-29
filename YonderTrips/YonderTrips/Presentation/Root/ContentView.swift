//
//  ContentView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    
    private let container = DIContainer()
    
    @StateObject private var rootRouter = RootFlowRouter()
    @StateObject private var signInRouter = SignInFlowRouter()
    @StateObject private var homeRouter = HomeFlowRouter()
    
    var body: some View {
        
        rootView
            .animation(.easeInOut(duration: 0.3), value: rootRouter.rootFlow)
    }
}

extension ContentView {
    
    @ViewBuilder
    var rootView: some View {
        
        switch rootRouter.rootFlow {
        case .signIn:
            SignInView(viewModel: container.makeSignInViewModel())
                .environmentObject(rootRouter)
                .environmentObject(signInRouter)
        case .signUp:
            SignUpView(viewModel: container.makeSignUpViewModel())
                .environmentObject(rootRouter)
        case .home:
            HomeView()
                .handleNotificationNavigation()
                .environmentObject(rootRouter)
                .environmentObject(homeRouter)
        }
    }
}

#Preview {
    ContentView()
}
