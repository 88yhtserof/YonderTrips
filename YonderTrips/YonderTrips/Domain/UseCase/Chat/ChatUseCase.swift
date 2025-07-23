//
//  ChatUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation
import Combine

import RealmSwift

final class ChatUseCase {
    
    private let localRepository: LocalChatRepository
    private let remoteRepository: RemoteChatRepository
    private var socketManager: ChatSocketManagerProtocol = ChatSocketManager.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init(localRepository: LocalChatRepository, remoteRepository: RemoteChatRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
        
        socketManager.incomingMessages
            .sink { chatResponse in
                self.localRepository.addChat(chatResponse)
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func createChatRoom(opponentId: String) async throws -> ChatRoomResponse {
        
        let chatRoomResponse: ChatRoomResponse = try await remoteRepository.requestCreatingChatRoom(with: opponentId)
        
        localRepository.addChatRoom(chatRoomResponse)
        
        return chatRoomResponse
    }
    
    @MainActor
    func fetchLatestChats(roomId: String, limit: Int? = nil) async throws -> ChatPaginationResult {
        
        let localResult = localRepository.fetchLatestChats(roomId: roomId, limit: limit)
        
        let remoteChatList = try await remoteRepository.requestChatList(roomId: roomId, next: "")
        
        remoteChatList.data.forEach { localRepository.addChat($0) }
        
        return localRepository.fetchLatestChats(roomId: roomId, limit: limit)
    }
    
    @MainActor
    func fetchChatsBefore(roomId: String, cursor: Date, limit: Int? = nil) async throws -> ChatPaginationResult {
        
        return localRepository.fetchChatsBefore(roomId: roomId, cursor: cursor, limit: limit)
    }
    
    @MainActor
    func fetchChatsAfter(roomId: String, cursor: Date, limit: Int? = nil) async throws -> ChatPaginationResult {
        
        return localRepository.fetchChatsAfter(roomId: roomId, cursor: cursor, limit: limit)
    }
    
    @MainActor
    func sendChat(roomId: String, content: String, files: [String] = []) async throws -> ChatResponse {
        
        let response = try await remoteRepository.requestChat(roomId: roomId, content: content, files: files)
        
        return response
    }
    
    func observeMessagesAfter(roomId: String, cursor: Date, completion: @escaping (ChatPaginationResult) -> Void) -> NotificationToken? {
        
        return localRepository.observeMessagesAfter(roomId: roomId, cursor: cursor, completion: completion)
    }
    
    func connectSocket(with roomId: String) {
        
        socketManager.connect(roomId: roomId)
    }
    
    func disconnectSocket() {
        
        socketManager.disconnect()
    }
}
