//
//  ChatRoomResponse.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatRoomResponse {
    let roomId: String
    let title: String
    let participants: [UserInfo]
    let lastChat: ChatResponse?
}
