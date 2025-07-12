//
//  ChatViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/12/25.
//

import Foundation

import RealmSwift

final class ChatViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let chatUseCase: ChatUseCase
    private var token: NotificationToken?
    
    private let opponentId = "6872371d84627263fbdf819c"
    
    init(chatUseCase: ChatUseCase) {
        self.chatUseCase = chatUseCase
        
        binding()
    }
    
    struct State {
        var roomId = ""
        var chatList: [ChatResponse] = []
        var lastDate: Date?
        
        var inputText: String = ""
    }
    
    func binding() {
        
    }
    
    deinit {
        token?.invalidate()
    }
}

//MARK: - Action
extension ChatViewModel {
    
    enum Action {
        case observeChatList
        case createChatRoom
        case fetchChatList
        case sendChat
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .observeChatList:
            startObserving()
            
        case .createChatRoom:
            createChatRoom()
            
        case .fetchChatList:
            fetchChatList()
            
        case .sendChat:
            sendChat()
        }
    }
}

private extension ChatViewModel {
    
    func startObserving() {
        
        token = chatUseCase.observe(roomId: state.roomId, lastDate: state.lastDate) { [weak self] chatList in
            Task { @MainActor in
                self?.state.chatList = chatList
            }
        }
    }
    
    @MainActor
    func createChatRoom() {
        print(#function)
        
        Task {
        
            do {
                let chatRoomResponse = try await chatUseCase.createChatRoom(opponentId: opponentId)
                state.roomId = chatRoomResponse.roomId
            } catch {
                print("Error: \(error)")
            }}
    }
    
    @MainActor
    func fetchChatList() {
        print(#function, state.roomId)
        
        Task {
            do {
                state.chatList = try await chatUseCase.fetchChatList(roomId: state.roomId, lastDate: state.lastDate)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    @MainActor
    func sendChat() {
        print(#function)
        
        Task {
        
            do {
                let response = try await chatUseCase.sendChat(roomId: state.roomId, content: state.inputText)
                state.lastDate = YTDateFormatter.date(from: response.createdAt, format: .iso8601UTC)
                state.inputText = ""
                
            } catch {
                print("Error: \(error)")
            }}
    }
}
