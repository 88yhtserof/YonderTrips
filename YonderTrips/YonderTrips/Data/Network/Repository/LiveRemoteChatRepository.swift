//
//  LiveRemoteChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

struct LiveRemoteChatRepository: RemoteChatRepository {
    
    func requestCreatingChatRoom(with opponentId: String) async throws -> ChatRoomResponse {
        
        let request = CreatingChatRequestDTO(opponentId: opponentId)
        
        let response: ChatRoomResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .chat(.createChatRoom(request)))
        
        return response.toEntity()
    }
    
    func requestChatRoomList() async throws -> ChatRoomListResponse {
        
        let response: ChatRoomListResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .chat(.getChatRoomList))
        
        return response.toEntity()
    }
    
    func requestChat(roomId: String, content: String, files: [String]) async throws -> ChatResponse {
        
        let request = ChatMessageRequestDTO(content: content, files: files)
        
        let response: ChatResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .chat(.sendChatMessage(roomId, request)))
        
        return response.toEntity()
    }
    
    func requestChatList(roomId: String, next: String) async throws -> ChatListResponse {
        
        let response: ChatListResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .chat(.getChatMessageList(roomId, next)))
        
        return response.toEntity()
    }
}
