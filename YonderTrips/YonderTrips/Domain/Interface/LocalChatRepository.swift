//
//  LocalChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

import RealmSwift

protocol LocalChatRepository {
    
    func containsChatRoom(roomId: String) -> Bool
    
    func addChatRoom(_ room: ChatRoomResponse)
    
    func fetchChatRoomList() -> [ChatRoomResponse]
    
    func containsChat(chatId: String) -> Bool
    
    func fetchChatListWithCursor(
        roomId: String,
        cursor: Date?,
        direction: PaginationDirection,
        limit: Int?
    ) -> ChatPaginationResult
    
    func fetchChatsAfter(
        roomId: String,
        cursor: Date?,
        limit: Int?
    ) -> ChatPaginationResult
    
    func fetchChatsBefore(
        roomId: String,
        cursor: Date?,
        limit: Int?
    ) -> ChatPaginationResult
    
    func fetchLatestChats(
        roomId: String,
        limit: Int?
    ) -> ChatPaginationResult
    
    func fetchChatsAround(
        roomId: String,
        cursor: Date,
        beforeLimit: Int?,
        afterLimit: Int?
    ) -> (before: ChatPaginationResult, after: ChatPaginationResult)
    
    func addChat(_ chat: ChatResponse)
    
    func observeMessages(
        roomId: String,
        lastDate: Date?,
        completion: @escaping ([ChatResponse]) -> Void
    ) -> NotificationToken?
    
    func observeMessagesAfter(
        roomId: String,
        cursor: Date,
        completion: @escaping (ChatPaginationResult) -> Void
    ) -> NotificationToken?
}
