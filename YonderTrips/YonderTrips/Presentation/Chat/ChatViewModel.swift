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
        
        var currentCursor: Date?
        var hasMoreMessages: Bool = true
        var isLoadingMore: Bool = false
        
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
        case fetchInitialChatList
        case loadMoreMessages
        case sendChat
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .createChatRoom:
            createChatRoom()
            
        case .observeChatList:
            startObserving()
            
        case .fetchInitialChatList:
            fetchInitialChatList()
            
        case .loadMoreMessages:
            loadMoreMessages()
            
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
                fetchInitialChatList()
            } catch {
                print("Error: \(error)")
            }}
    }
    
    func startObserving() {
        
        guard let roomId else {
            YonderTripsLogger.shared.debug("Could not fetch chat list. Room ID is nil.")
            return
        }
        
        let observationCursor = state.currentCursor ?? Date()
        
        token = chatUseCase.observeMessagesAfter(roomId: roomId, cursor: observationCursor) { [weak self] result in
            Task { @MainActor in
                guard let self = self else { return }
                
                self.state.chatList.append(contentsOf: result.chats)
                
                if let newCursor = result.nextCursor {
                    self.state.currentCursor = newCursor
                }
            }
        }
    }
    
    @MainActor
    func fetchInitialChatList() {
        
        Task {
            guard let roomId else {
                YonderTripsLogger.shared.debug("Could not fetch chat list. Room ID is nil.")
                return
            }
            
            do {
                let result = try await chatUseCase.fetchLatestChats(roomId: roomId, limit: 20)
                
                state.chatList = result.chats
                state.currentCursor = result.nextCursor
                state.hasMoreMessages = result.hasMore
                
                chatUseCase.connectSocket(with: roomId)
                
            } catch {
                print("Error: \(error)")
            }
        }
    }

    @MainActor
    func loadMoreMessages() {
        
        guard !state.isLoadingMore,
              state.hasMoreMessages,
              let roomId = roomId,
              let cursor = state.currentCursor else {
            return
        }
        
        state.isLoadingMore = true
        defer {
            state.isLoadingMore = false
        }
        
        Task {
            do {
                let result = try await chatUseCase.fetchChatsBefore(roomId: roomId, cursor: cursor, limit: 20)
                
                state.chatList.insert(contentsOf: result.chats, at: 0)
                state.currentCursor = result.nextCursor
                state.hasMoreMessages = result.hasMore
                
            } catch {
                print("Error loading more messages: \(error)")
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
                
                if let sentDate = YTDateFormatter.date(from: response.createdAt, format: .iso8601UTC) {
                    state.currentCursor = sentDate
                }
                
                state.inputText = ""
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
