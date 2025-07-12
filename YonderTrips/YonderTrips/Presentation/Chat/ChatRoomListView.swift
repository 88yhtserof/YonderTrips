//
//  ChatRoomListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/10/25.
//

import SwiftUI

struct ChatRoomListView: View {
    // 686d05b784627263fbdba4eb
    private let opponentId = "6836e97b0b936fc97471104a"
    @State private var roomId = ""
    @State private var chatList: [ChatResponse] = []
    @State private var lastDate: Date?
    @State private var inputText: String = ""
    
    private let useCase = ChatUseCase(localRepository: LiveLocalChatRepository(), remoteRepository: LiveRemoteChatRepository())
    
    var body: some View {
        
        VStack {
            
            Button {
                createChatRoom()
                
            } label: {
                Text("채팅방 만들기")
            }
            
            if !roomId.isEmpty {
                
                VStack {
                    ForEach(chatList, id: \.self) { chat in
                        Text(chat.content)
                    }
                    
                    TextField("채팅을 입력하세요.", text: $inputText)
                    
                    Button {
                        sendChat()
                    } label: {
                        Text("Send Chat")
                    }
                }
                .onAppear {
                    fetchChatList()
//                    observeChatList()
                }
            }
        }

    }
    
    func createChatRoom() {
        print(#function)
        
        Task {
        
            do {
                let chatRoomResponse = try await useCase.createChatRoom(opponentId: opponentId)
                self.roomId = chatRoomResponse.roomId
            } catch {
                print("Error: \(error)")
            }}
    }
    
    func fetchChatList() {
        print(#function)
        
        
        Task {
            do {
                chatList = try await useCase.fetchChatList(roomId: roomId, lastDate: lastDate)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func sendChat() {
        print(#function)
        
        Task {
        
            do {
                let response = try await useCase.sendChat(roomId: roomId, content: inputText)
                lastDate = YTDateFormatter.date(from: response.createdAt, format: .iso8601UTC)
                inputText = ""
                
            } catch {
                print("Error: \(error)")
            }}
    }
    
    func observeChatList() {
        print(#function)
        
        useCase.observe { list in
            self.chatList = list
        }
    }
}

#Preview {
    ChatRoomListView()
}
