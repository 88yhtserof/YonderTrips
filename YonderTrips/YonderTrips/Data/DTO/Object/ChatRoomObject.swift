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
    @Persisted var lastMessage: String?
    @Persisted var lastUpdatedAt: Date?

    @Persisted(originProperty: "room") var chatList: LinkingObjects<ChatObject>

    convenience init(
        roomId: String,
        title: String,
        participants: List<UserInfoObject>,
        lastMessage: String? = nil,
        lastUpdatedAt: Date? = nil
    ) {
        self.init()
        self.roomId = roomId
        self.title = title
        self.participants = participants
        self.lastMessage = lastMessage
        self.lastUpdatedAt = lastUpdatedAt
    }
}

