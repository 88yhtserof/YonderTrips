//
//  ChatSocketManager.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/12/25.
//

import Foundation
import Combine

import SocketIO

final class ChatSocketManager: ChatSocketManagerProtocol {
    
    static let shared = ChatSocketManager()
    let incomingMessages = PassthroughSubject<ChatResponse, Never>()
    
    private let url = URL(string: AuthorizationProvider.yonderTrips.url ?? "")
    private var manager: SocketManager?
    private var socket: SocketIOClient?
    
    private init() { }
    
    func connect(roomId: String) {
        
        guard let url else {
            YonderTripsLogger.shared.debug("Could not create URL")
            return
        }
        
        manager = SocketManager(
            socketURL: url,
            config: [
                .log(true),
                .compress,
                .extraHeaders([
                    "Authorization": AuthTokenProvider.access.token ?? "",
                    "SeSACKey": YTAPIProvider.apiKey
                ])
            ]
        )
        
        socket = manager!.socket(forNamespace: "/chats-\(roomId)")
        
        establishConnection()
        listenForMessages()
    }
    
    func disconnect() {
        
        closeConnection()
    }
}

private extension ChatSocketManager {
    
    func establishConnection() {
        socket?.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        socket?.connect()
    }
    
    func closeConnection() {
        socket?.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        socket?.disconnect()
    }
    
    func listenForMessages() {
        socket?.on("chat") { [weak self] dataArray, ack in
            
            guard let jsonDict = dataArray.first as? [String: Any] else {
                YonderTripsLogger.shared.debug("Could not decode data")
                return
            }
            let data = try! JSONSerialization.data(withJSONObject: jsonDict)
            let decoded = try! JSONDecoder().decode(ChatResponseDTO.self, from: data)
            
            let chatResponse = decoded.toEntity()
            self?.incomingMessages.send(chatResponse)
        }
    }
}
