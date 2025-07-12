//
//  ChatUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

import RealmSwift

struct ChatUseCase {
    
    private let localRepository: LocalChatRepository
    private let remoteRepository: RemoteChatRepository
    
    
    init(localRepository: LocalChatRepository, remoteRepository: RemoteChatRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
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
            let existingChatList = try localRepository.fetchChatList(roomId: roomId, lastDate: nil)
            print("existingChatList", existingChatList.count)
            
            if let last = existingChatList.last {
                next = last.createdAt
                print("next", next)
            }
        }
        
        let remoteChatList = try await remoteRepository.requestChatList(roomId: roomId, next: next)
        print("remoteChatList", remoteChatList.data.count)
        
        remoteChatList.data
            .forEach{
                print($0.content)
                localRepository.addChat($0)
            }
        
        return try localRepository.fetchChatList(roomId: roomId, lastDate: lastDate)
    }
    
    @MainActor
    func sendChat(roomId: String, content: String, files: [String] = []) async throws -> ChatResponse {
        
        let response = try await remoteRepository.requestChat(roomId: roomId, content: content, files: files)
        localRepository.addChat(response)
        return response
    }
    
    func observe(completion: @escaping ([ChatResponse]) -> Void) -> NotificationToken {
        localRepository.observeMessages(completion: completion)
    }
}
