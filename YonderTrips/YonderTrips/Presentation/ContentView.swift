//
//  ContentView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    
    private let container = DIContainer()
    @EnvironmentObject private var rootRouter: RootFlowRouter
//    @StateObject private var router: SignInFlowRouter
    
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
        case .signUp:
            SignUpView(viewModel: container.makeSignUpViewModel())
        case .home:
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
