//
//  ChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

protocol ChatRepository {
    
    func requestCreatingChatRoom(with opponentId: String) async throws -> ChatRoomResponse
    func requestChatRoomList() async throws -> ChatRoomListResponse
    func requestChatMessages(roomId: String, content: String, files: [String]?) async throws -> ChatResponse
    func requestChatMessages(roomId: String, next: String) async throws -> ChatListResponse
}
