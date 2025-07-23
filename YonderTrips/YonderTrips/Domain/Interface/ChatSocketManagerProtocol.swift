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
    
    var incomingMessages: PassthroughSubject<ChatResponse, Never> { get }
    
    func connect(roomId: String)
    
    func disconnect()
}
