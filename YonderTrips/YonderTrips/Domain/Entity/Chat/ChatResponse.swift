//
//  ChatResponse.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatResponse: Hashable {
    let chatId: String
    let roomId: String
    let content: String
    let createdAt: String
    let updatedAt: String
    let sender: UserInfo
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
    
    var isMyMessage: Bool {
        return UserDefaults.standard.string(forKey: "userId") == sender.userId
    }
}
