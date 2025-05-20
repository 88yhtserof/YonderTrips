//
//  ContentView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    
    private let container = DIContainer()
    @EnvironmentObject private var router: RootFlowRouter
    
    var body: some View {
        
        rootView
            .animation(.easeInOut(duration: 0.3), value: router.rootFlow)
    }
}

extension ContentView {
    
    @ViewBuilder
    var rootView: some View {
        
        switch router.rootFlow {
        case .signIn:
            SignInView()
        case .signUp:
            SignUpView(viewModel: container.makeSignUpViewModel())
        }
    }
}

#Preview {
    ContentView()
}
