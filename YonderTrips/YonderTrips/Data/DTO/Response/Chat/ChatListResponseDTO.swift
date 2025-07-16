//
//  ChatListResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatListResponseDTO: Decodable {
    let data: [ChatResponseDTO]
}

extension ChatListResponseDTO {
    
    func toEntity() -> ChatListResponse {
        return ChatListResponse(
            data: self.data.map { $0.toEntity() } // ChatResponseDTO의 toEntity 호출
        )
    }
}
