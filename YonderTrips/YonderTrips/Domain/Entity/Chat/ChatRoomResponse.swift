//
//  ChatRoomResponse.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatRoomResponse {
    let roomId: String
    let createdAt: String
    let updatedAt: String
    let participants: [UserInfo]
    let lastChat: ChatResponse?

    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case createdAt
        case updatedAt
        case participants
        case lastChat
    }
}
