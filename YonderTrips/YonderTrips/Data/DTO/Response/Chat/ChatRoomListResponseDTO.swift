//
//  ChatRoomListResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatRoomListResponseDTO: Decodable {
    let data: [ChatRoomResponseDTO]
}

extension ChatRoomListResponseDTO {
    
    func toEntity() -> ChatRoomListResponse {
        return ChatRoomListResponse(
            data: self.data.map { $0.toEntity() }
        )
    }
}
