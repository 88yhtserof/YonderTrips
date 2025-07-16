//
//  ChatError.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import Foundation

enum ChatError: LocalizedError {
    case failedToFetchChatList
    case failedToSendMessage
    case unknownError

    var errorDescription: String? {
        switch self {
        case .failedToFetchChatList:
            return "채팅 내역을 불러오지 못했습니다."
        case .failedToSendMessage:
            return "메시지 전송에 실패했습니다."
        case .unknownError:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
