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
    
    private let opponentId: String
    private var roomId: String? = nil
    private var token: NotificationToken?
    
    init(opponentId: String, chatUseCase: ChatUseCase) {
        self.opponentId = opponentId
        self.chatUseCase = chatUseCase
        
        binding()
    }
    
    struct State {
        var chatList: [ChatResponse] = []
        var lastDate: Date?
        
        var inputText: String = ""
    }
    
    func binding() {
        
    }
    
    deinit {
        print("ChatViewModel deinit")
        token?.invalidate()
        chatUseCase.disconnectSocket()
    }
}

//MARK: - Action
extension ChatViewModel {
    
    enum Action {
        case createChatRoom
        case observeChatList
        case fetchChatList
        case sendChat
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .createChatRoom:
            createChatRoom()
            
        case .observeChatList:
            startObserving()
            
        case .fetchChatList:
            fetchChatList()
            
        case .sendChat:
            sendChat()
        }
    }
}

private extension ChatViewModel {
    
    @MainActor
    func createChatRoom() {
        
        Task {
            
            do {
                let chatRoomResponse = try await chatUseCase.createChatRoom(opponentId: opponentId)
                self.roomId = chatRoomResponse.roomId
                
                startObserving()
                fetchChatList()
            } catch {
                print("Error: \(error)")
            }}
    }
    
    func startObserving() {
        
        guard let roomId else {
            YonderTripsLogger.shared.debug("Could not fetch chat list. Room ID is nil.")
            return
        }
        
        token = chatUseCase.observe(roomId: roomId, lastDate: state.lastDate) { [weak self] chatList in
            Task { @MainActor in
                self?.state.chatList.append(contentsOf: chatList)
            }
        }
    }
    
    @MainActor
    func fetchChatList() {
        
        Task {
            guard let roomId else {
                YonderTripsLogger.shared.debug("Could not fetch chat list. Room ID is nil.")
                return
            }
            
            do {
                state.chatList = try await chatUseCase.fetchChatList(roomId: roomId, lastDate: state.lastDate)
                
                chatUseCase.connectSocket(with: roomId)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    @MainActor
    func sendChat() {
        
        Task {
            guard let roomId else {
                YonderTripsLogger.shared.debug("Could not send chat. Room ID is nil.")
                return
            }
            
            do {
                let response = try await chatUseCase.sendChat(roomId: roomId, content: state.inputText)
                state.lastDate = YTDateFormatter.date(from: response.createdAt, format: .iso8601UTC)
                state.inputText = ""
                
            } catch {
                print("Error: \(error)")
            }}
    }
}
