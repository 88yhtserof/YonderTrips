//
//  ChatSocketManagerProtocol.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/14/25.
//

import Foundation
import Combine

protocol ChatSocketManagerProtocol {
    
    static var shared: ChatSocketManager { get }
    
    /// 수신된 채팅 메시지를 전달하는 스트림
    var incomingMessages: PassthroughSubject<ChatResponse, Never> { get }
    
    /// 소켓 연결을 시작
    /// - Parameter roomId: 연결할 채팅방 ID
    func connect(roomId: String)
    
    /// 소켓 연결 해제
    func disconnect()
}
