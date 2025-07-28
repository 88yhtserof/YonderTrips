//
//  ChatRoomObject.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/11/25.
//

import Foundation

import RealmSwift

class ChatRoomObject: Object {
    @Persisted(primaryKey: true) var roomId: String
    @Persisted var title: String
    @Persisted var participants: List<UserInfoObject>
    @Persisted var lastChat: ChatObject?
    
    @Persisted(originProperty: "room") var chatList: LinkingObjects<ChatObject>

    convenience init(
        roomId: String,
        title: String,
        participants: List<UserInfoObject>,
        lastChat: ChatObject? = nil
    ) {
        self.init()
        self.roomId = roomId
        self.title = title
        self.participants = participants
        self.lastChat = lastChat
    }
}

extension ChatRoomObject {
    
    func toEntity() -> ChatRoomResponse {
        return ChatRoomResponse(
            roomId: self.roomId,
            title: self.title,
            participants: self.participants.map { $0.toEntity() },
            lastChat: self.lastChat?.toEntity()
        )
    }
}
