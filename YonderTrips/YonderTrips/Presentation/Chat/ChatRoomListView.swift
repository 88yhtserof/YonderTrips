//
//  ChatRoomListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import SwiftUI

struct ChatRoomListView: View {
    
    @StateObject var viewModel: ChatViewModel
    
    private let useCase = ChatUseCase(localRepository: LiveLocalChatRepository(), remoteRepository: LiveRemoteChatRepository())
    
    var body: some View {
        
        VStack {
            
            if viewModel.state.roomId.isEmpty {
                Button {
                    viewModel.action(.createChatRoom)
                    
                } label: {
                    Text("채팅방 만들기")
                }
            } else {
                
                VStack {
                    ForEach(viewModel.state.chatList, id: \.self) { chat in
                        Text(chat.content)
                    }
                    
                    TextField("채팅을 입력하세요.", text: $viewModel.state.inputText)
                    
                    Button {
                        viewModel.action(.sendChat)
                    } label: {
                        Text("Send Chat")
                    }
                }
                .onAppear {
                    viewModel.action(.observeChatList)
                    viewModel.action(.fetchChatList)
                    
                }
            }
        }
        
    }
}
