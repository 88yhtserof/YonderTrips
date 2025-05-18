//
//  YonderTripsApp.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/12/25.
//

import SwiftUI

@main
struct YonderTripsApp: App {
    var body: some Scene {
        WindowGroup {
            let userInfoValidationUseCase = UserValidationUseCase()
            let signUpUseCase = SignUpUseCase(networkService: NetworkService(logger: YonderTripsLogger.shared))
            let viewModel = SignUpViewModel(userInfoValidationUseCase: userInfoValidationUseCase, signUpUseCase: signUpUseCase)
            SignUpView(viewModel: viewModel)
        }
    }
}
