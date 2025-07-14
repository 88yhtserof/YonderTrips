//
//  ChatListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import SwiftUI

struct ChatListView: View {
    
    @StateObject var viewModel: ChatViewModel
    
    var body: some View {
        
        ScrollView {
            
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
                viewModel.action(.createChatRoom)
            }
        }
        
    }
}
