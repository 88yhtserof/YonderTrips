//
//  ChatMessageRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/9/25.
//

import Foundation

struct ChatMessageRequestDTO: Encodable {
    let content: String
    let files: [String]
}
