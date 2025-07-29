//
//  ChatRoomResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatRoomResponseDTO: Decodable {
    let roomId: String
    let createdAt: String
    let updatedAt: String
    let participants: [UserInfoResponseDTO]
    let lastChat: ChatResponseDTO?

    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case createdAt
        case updatedAt
        case participants
        case lastChat
    }
}

extension ChatRoomResponseDTO {
    
    func toEntity() -> ChatRoomResponse {
        return ChatRoomResponse(
            roomId: self.roomId,
            title: self.lastChat?.sender.nick ?? "",
            participants: self.participants.map { $0.toEntity() },
            lastChat: self.lastChat?.toEntity()
        )
    }
}
