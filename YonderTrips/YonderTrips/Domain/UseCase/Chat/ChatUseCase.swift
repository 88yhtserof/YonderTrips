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
    func fetchChatList(roomId: String, lastDate: Date?) async throws -> [ChatResponse] {
        
        var next: String = ""
        
        if let lastDate {
            next = YTDateFormatter.string(from: lastDate, format: .iso8601UTC)
            
        } else {
            let existingChatList = localRepository.fetchChatList(roomId: roomId, lastDate: nil)
            
            if let last = existingChatList.last {
                next = last.createdAt
            }
        }
        
        let remoteChatList = try await remoteRepository.requestChatList(roomId: roomId, next: next)
        
        remoteChatList.data
            .forEach{ localRepository.addChat($0) }
        
        return localRepository.fetchChatList(roomId: roomId, lastDate: lastDate)
    }
    
    @MainActor
    func sendChat(roomId: String, content: String, files: [String] = []) async throws -> ChatResponse {
        
        let response = try await remoteRepository.requestChat(roomId: roomId, content: content, files: files)
        
        return response
    }
    
    func observe(roomId: String, lastDate: Date?, completion: @escaping ([ChatResponse]) -> Void) -> NotificationToken? {
        
        localRepository
            .observeMessages(roomId: roomId, lastDate: lastDate, completion: completion)
    }
    
    func connectSocket(with roomId: String) {
        
        socketManager.connect(roomId: roomId)
    }
    
    func disconnectSocket() {
        
        socketManager.disconnect()
    }
}
