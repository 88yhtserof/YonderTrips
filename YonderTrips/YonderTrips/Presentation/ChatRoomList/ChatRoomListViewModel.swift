//
//  ChatRoomList.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/28/25.
//

import Foundation

final class ChatRoomListViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let chatRoomUseCase: ChatRoomUseCase
    
    init(chatRoomUseCase: ChatRoomUseCase) {
        self.chatRoomUseCase = chatRoomUseCase
        
        binding()
    }
    
    struct State {
        var chatRoomList: [ChatRoomResponse] = []
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension ChatRoomListViewModel {
    
    enum Action {
        case onAppear
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .onAppear:
            Task {
                do {
                    state.chatRoomList = try await chatRoomUseCase.fetchChatRoomList()
                } catch {
                    YonderTripsLogger.shared.error(ChatError.failedToFetchChatRoomList)
                }
            }
        }
    }
}
