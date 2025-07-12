//
//  ChatObject.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation
import RealmSwift

class ChatObject: Object {
    @Persisted(primaryKey: true) var chatId: String
    @Persisted var roomId: String
    @Persisted var content: String
    @Persisted(indexed: true) var createdAt: Date
    @Persisted var updatedAt: Date
    @Persisted var sender: UserInfoObject?
    @Persisted var files: List<String>
    
    @Persisted var room: ChatRoomObject?
    
    convenience init(chatId: String, roomId: String, content: String, createdAt: Date, updatedAt: Date, sender: UserInfoObject, files: [String]) {
        self.init()
        self.chatId = chatId
        self.roomId = roomId
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.sender = sender
        self.files.append(objectsIn: files)
    }
}

extension ChatObject {
    
    func toEntity() -> ChatResponse {
        let createdAtString = YTDateFormatter.string(from: createdAt, format: .iso8601UTC)
        let updatedAtString = YTDateFormatter.string(from: updatedAt, format: .iso8601UTC)
        
        return ChatResponse(
            chatId: chatId,
            roomId: roomId,
            content: content,
            createdAt: createdAtString,
            updatedAt: updatedAtString,
            sender: sender!.toEntity(),
            files: Array(files)
        )
    }
}
