//
//  ChatRoomUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/28/25.
//

import Foundation

final class ChatRoomUseCase {
    
    private let localRepository: LocalChatRepository
    private let remoteRepository: RemoteChatRepository
    
    init(localRepository: LocalChatRepository, remoteRepository: RemoteChatRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    @MainActor
    func createChatRoom(opponentId: String) async throws -> ChatRoomResponse {
        
        let chatRoomResponse: ChatRoomResponse = try await remoteRepository.requestCreatingChatRoom(with: opponentId)
        
        localRepository.addChatRoom(chatRoomResponse)
        
        return chatRoomResponse
    }
    
    @MainActor
    func fetchChatRoomList() async throws -> [ChatRoomResponse] {
        let remoteChatRoomList = try await remoteRepository.requestChatRoomList()
        
        remoteChatRoomList.data
            .forEach{ localRepository.addChatRoom($0) }
        
        return localRepository.fetchChatRoomList()
    }
}
