//
//  SignUpViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import Foundation


final class SignUpViewModel: ObservableObject {
    
    @Published var state = State()
    
    private let userInfoValidationUseCase: UserValidationUseCase
    
    init(userInfoValidationUseCase: UserValidationUseCase) {
        self.userInfoValidationUseCase = userInfoValidationUseCase
    }
    
    struct State {
        var email: String = ""
        var password: String = ""
        var nickname: String = ""
        
        var emailValidationMessage: String? = nil
        var passwordValidationMessage: String? = nil
        var nicknameValidationMessage: String? = nil
        
        var emailValidationState: ValidationTextField.ValidationState = .none
        var passwordValidationState: ValidationTextField.ValidationState = .none
        var nicknameValidationState: ValidationTextField.ValidationState = .none
        
    }
    
    enum Action {
        case validateEmail
        case validatePassword(String)
        case validateNickname(String)
    }
    
    func action(_ action: Action) {
        
        switch action {
        case .validateEmail:
            do {
                let message = try userInfoValidationUseCase.validateUserInfo(.email(state.email))
                state.emailValidationMessage = message
                state.emailValidationState = .valid
                
            } catch {
                state.emailValidationMessage = error.localizedDescription
                state.emailValidationState = .invalid
            }
            
        case .validatePassword(let string):
            do {
                let message = try userInfoValidationUseCase.validateUserInfo(.password(string))
                state.passwordValidationMessage = message
                state.passwordValidationState = .valid
                
            } catch {
                state.passwordValidationMessage = error.localizedDescription
                state.passwordValidationState = .invalid
            }
            
        case .validateNickname(let string):
            do {
                let message = try userInfoValidationUseCase.validateUserInfo(.nick(string))
                state.nicknameValidationMessage = message
                state.nicknameValidationState = .valid
                
            } catch {
                state.nicknameValidationMessage = error.localizedDescription
                state.nicknameValidationState = .invalid
            }
        }
    }
}
