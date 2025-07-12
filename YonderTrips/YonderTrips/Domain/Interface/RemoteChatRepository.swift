//
//  RemoteChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

protocol RemoteChatRepository {
    
    func requestCreatingChatRoom(with opponentId: String) async throws -> ChatRoomResponse
    func requestChatRoomList() async throws -> ChatRoomListResponse
    func requestChat(roomId: String, content: String, files: [String]) async throws -> ChatResponse
    func requestChatList(roomId: String, next: String) async throws -> ChatListResponse
}
