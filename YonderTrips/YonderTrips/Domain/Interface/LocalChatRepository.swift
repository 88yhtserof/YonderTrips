//
//  LocalChatRepository.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

import RealmSwift

protocol LocalChatRepository {
    
    func addChatRoom(_ room: ChatRoomResponse)
    func fetchChatList(roomId: String, lastDate: Date?) throws -> [ChatResponse]
    func addChat(_ chat: ChatResponse)
    func observeMessages(completion: @escaping ([ChatResponse]) -> Void) -> NotificationToken
}
