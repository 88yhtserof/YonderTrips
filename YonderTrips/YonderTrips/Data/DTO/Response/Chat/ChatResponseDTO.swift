//
//  ChatResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatResponseDTO: Decodable {
    let chatId: String
    let roomId: String
    let content: String
    let createdAt: String
    let updatedAt: String
    let sender: UserInfoResponseDTO
    let files: [String]
    
    enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case roomId = "room_id"
        case content
        case createdAt
        case updatedAt
        case sender
        case files
    }
}

extension ChatResponseDTO {
    
    func toEntity() -> ChatResponse {
        return ChatResponse(
            chatId: self.chatId,
            roomId: self.roomId,
            content: self.content,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt,
            sender: self.sender.toEntity(), // UserInfoResponseDTO의 toEntity 호출
            files: self.files
        )
    }
}
