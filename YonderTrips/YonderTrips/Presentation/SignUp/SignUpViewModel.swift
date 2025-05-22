//
//  SignUpViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/16/25.
//

import Foundation
import Combine

final class SignUpViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let userInfoValidationUseCase: UserValidationUseCaseType
    private let signUpUseCase: SignUpUseCaseType
    private var cancellables = Set<AnyCancellable>()
    
    init(userInfoValidationUseCase: UserValidationUseCaseType, signUpUseCase: SignUpUseCaseType) {
        self.userInfoValidationUseCase = userInfoValidationUseCase
        self.signUpUseCase = signUpUseCase
        
        binding()
    }
    
    struct State {
        var email: String = ""
        var password: String = ""
        var nickname: String = ""
        var phoneNumber: String = ""
        var instruction: String = ""
        
        var emailValidationMessage: String? = nil
        var passwordValidationMessage: String? = nil
        var nicknameValidationMessage: String? = nil
        
        var emailValidationState: ValidationTextField.ValidationState = .none
        var passwordValidationState: ValidationTextField.ValidationState = .none
        var nicknameValidationState: ValidationTextField.ValidationState = .none
        
        var isEnabledDoneButton: Bool = false
        
        var isShownErrorAlert: Bool = false
        var alertMessage: String = ""
    }
    
    func binding() {
        
        // isEnabledDoneButton
        let emailStatePublisher: AnyPublisher<ValidationTextField.ValidationState, Never> = $state
            .map { $0.emailValidationState }
            .eraseToAnyPublisher()
            
        let passwordStatePublisher: AnyPublisher<ValidationTextField.ValidationState, Never> = $state
            .map { $0.passwordValidationState }
            .eraseToAnyPublisher()
            
        let nicknameStatePublisher: AnyPublisher<ValidationTextField.ValidationState, Never> = $state
            .map { $0.nicknameValidationState }
            .eraseToAnyPublisher()
        
        Publishers
            .CombineLatest3(emailStatePublisher, passwordStatePublisher, nicknameStatePublisher)
            .map { (emailState, passwordState, nicknameState) in
                let signInInfo: Bool = emailState == .valid && passwordState == .valid
                return signInInfo && nicknameState == .valid
            }
            .removeDuplicates()
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink { [weak self] (isEnabled: Bool) in
                self?.state.isEnabledDoneButton = isEnabled
            }
            .store(in: &cancellables)
    }
    
    enum Action {
        case validateEmail
        case validatePassword(String)
        case validateNickname(String)
        
        case didDoneButtonTapped(RootFlowRouter)
        case didPopupOverlayTapped
        case didPopupOKButtonTapped
    }
    
    @MainActor
    func action(_ action: Action) {
        
        switch action {
        case .validateEmail:
            do {
                try userInfoValidationUseCase.validateUserInfo(.email(state.email))
                
                Task {
                    do {
                        let message = try await signUpUseCase.requestEmailValidation(email: state.email)
                        
                        state.emailValidationMessage = message.message
                        state.emailValidationState = .valid
                        
                    } catch {
                        state.emailValidationMessage = error.localizedDescription
                        state.emailValidationState = .invalid
                    }
                }
                
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
            
        case .didDoneButtonTapped(let router):
            
            Task {
                do {
                    try await signUpUseCase
                        .requestSignUp(email: state.email,
                                       password: state.password,
                                       nick: state.nickname,
                                       phoneNum: state.phoneNumber,
                                       introduction: state.instruction)
                    
                    router.rootFlow = .home
                    
                } catch {
                    state.alertMessage = error.localizedDescription
                    state.isShownErrorAlert = true
                }
            }
        case .didPopupOverlayTapped:
            state.isShownErrorAlert = false
        case .didPopupOKButtonTapped:
            state.isShownErrorAlert = false
        }
    }
}
