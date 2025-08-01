//
//  DIContainer.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/19/25.
//

import SwiftUI

struct DIContainer {
    
    private let networkService: NetworkService
    
    private let tokenSecureStorage: TokenSecureRepository
    
    private let messageTokenRepository: MessageTokenRepository
    
    private let userInfoValidationUseCase: UserValidationUseCase
    
    private let localRepository = LiveLocalChatRepository()
    private let remoteRepository = LiveRemoteChatRepository()
    
    init() {
        self.networkService = NetworkService()
        
        self.tokenSecureStorage = TokenSecureRepository()
        
        self.messageTokenRepository = MessageTokenRepository()
        
        self.userInfoValidationUseCase = UserValidationUseCase()
    }
}

// ViewModel Factory
extension DIContainer {
    
    func makeSignUpViewModel() -> SignUpViewModel {
        
        let signUpUseCase = SignUpUseCase(networkService: networkService, tokenSecureStorage: tokenSecureStorage)
        return SignUpViewModel(userInfoValidationUseCase: userInfoValidationUseCase, signUpUseCase: signUpUseCase)
    }
    
    func makeSignInViewModel() -> SignInViewModel {
        
        let signInUseCase = SignInUseCase(networkService: networkService, tokenSecureStorage: tokenSecureStorage, messageTokenRepository: messageTokenRepository)
        return SignInViewModel(signInUseCase: signInUseCase)
    }
    
    func makeEmailSignInViewModel() -> EmailSignInViewModel {
        
        let signInUseCase = SignInUseCase(networkService: networkService, tokenSecureStorage: tokenSecureStorage, messageTokenRepository: messageTokenRepository)
        return EmailSignInViewModel(signInUseCase: signInUseCase)
    }
    
    func makeNewActivityViewModel(onError errorHandler: @escaping (String) -> Void) -> NewActivityViewModel {
        
        let newActivityUseCase = NewActivityUseCase()
        let activityUseCase = ActivityUseCase()
        return NewActivityViewModel(newActivityUseCase: newActivityUseCase, activityUseCase: activityUseCase, onError: errorHandler)
    }
    
    func makeActivityPostViewModel(onError errorHandler: @escaping (String) -> Void) -> ActivityPostViewModel {
        
        let activityPostUseCase = ActivityPostUseCase()
        return ActivityPostViewModel(activityPostUseCase: activityPostUseCase, onError: errorHandler)
    }
    
    func makeActivityListViewModel(category: ActivityCategory, country: ActivityCountry) -> ActivityListViewModel {
        
        let activityUseCase = ActivityUseCase()
        return ActivityListViewModel(activityUseCase: activityUseCase, category: category, country: country)
    }
    
    func makeOrderViewModel() -> OrderViewModel {
        
        let orderUseCase = OrderUseCase()
        return OrderViewModel(orderUseCase: orderUseCase)
    }
    
    func makeActivityPostListViewModel(category: ActivityCategory, country: ActivityCountry) -> ActivityPostListViewModel {
        
        let activityPostUseCase = ActivityPostUseCase()
        return ActivityPostListViewModel(
            activityPostUseCase: activityPostUseCase,
            category: category,
            country: country
        )
    }
    
    func makeChatRoomListViewModel() -> ChatRoomListViewModel {
        
        let chatRoomUseCase = ChatRoomUseCase(
            localRepository: localRepository,
            remoteRepository: remoteRepository
        )
        
        return ChatRoomListViewModel(chatRoomUseCase: chatRoomUseCase)
    }
    
    func makeChatViewModel(opponentId: String) -> ChatViewModel {
        
        let chatUseCase = ChatUseCase(
            localRepository: localRepository,
            remoteRepository: remoteRepository
        )
        
        let chatRoomUseCase = ChatRoomUseCase(
            localRepository: localRepository,
            remoteRepository: remoteRepository
        )
        
        return ChatViewModel(opponentId: opponentId, chatUseCase: chatUseCase, chatRoomUseCase: chatRoomUseCase)
    }
}

// Environment
extension DIContainer: EnvironmentKey {
    
    static let defaultValue: DIContainer = {
        return DIContainer()
    }()
}

extension EnvironmentValues {
    
    var container: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}
