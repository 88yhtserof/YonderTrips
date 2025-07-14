//
//  ChatRoomView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/12/25.
//

import SwiftUI

final class FlowRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    enum Path: Hashable {
        case chatList
    }
}


struct ChatRoomView: View {
    
    private let opponentId = "-"
    
    @StateObject private var router = FlowRouter()
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                Button {
                    
                    router.path.append(FlowRouter.Path.chatList)
                    
                } label: {
                    Text("채팅방 만들기")
                }
            }
            .navigationDestination(for: FlowRouter.Path.self) { flow in
                switch flow {
                case .chatList:
                    chatRoomListView()
                }
            }
        }
        
    }
    
    func chatRoomListView() -> some View {
        let localRepository = LiveLocalChatRepository()
        let remoteRepository = LiveRemoteChatRepository()
        let chatUseCase = ChatUseCase(
            localRepository: localRepository,
            remoteRepository: remoteRepository
        )
        
        let chatViewModel = ChatViewModel(opponentId: opponentId, chatUseCase: chatUseCase)
        
        return ChatListView(viewModel: chatViewModel)
    }
}
