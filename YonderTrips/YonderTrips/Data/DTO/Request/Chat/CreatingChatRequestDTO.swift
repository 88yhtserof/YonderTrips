//
//  CreatingChatRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct CreatingChatRequestDTO: Encodable {
    let opponentId: String

    enum CodingKeys: String, CodingKey {
        case opponentId = "opponent_id"
    }
}
