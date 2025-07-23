//
//  ChatView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/15/25.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            chatMessageList
            chatInputBar
        }
        .background(.gray15)
        .onAppear {
            viewModel.action(.createChatRoom)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("채팅")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }
    
    // MARK: - Chat Message List
    private var chatMessageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 8) {
                    if viewModel.state.isLoadingMore {
                        HStack {
                            Spacer()
                            ProgressView()
                                .scaleEffect(0.8)
                            Spacer()
                        }
                        .padding(.vertical, 8)
                    }
                    
                    if viewModel.state.hasMoreMessages && !viewModel.state.chatList.isEmpty {
                        Color.clear
                            .frame(height: 1)
                            .onAppear {
                                viewModel.action(.loadMoreMessages)
                            }
                    }
                    
                    ForEach(viewModel.state.chatList, id: \.chatId) { chat in
                        ChatMessageRow(chat: chat)
                            .id(chat.chatId)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .onChange(of: viewModel.state.chatList.count) { _ in
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: viewModel.state.isLoadingMore) { isLoading in
                if !isLoading && viewModel.state.chatList.count > 0 {
                    maintainScrollPosition(proxy: proxy)
                }
            }
        }
        .background(.gray15)
    }
    
    // MARK: - Chat Input Bar
    private var chatInputBar: some View {
        HStack(spacing: 12) {
            
            HStack {
                TextField("메시지를 입력하세요", text: $viewModel.state.inputText, axis: .vertical)
                    .textFieldStyle(PlainTextFieldStyle())
                    .lineLimit(1...5)
                
                if !viewModel.state.inputText.isEmpty {
                    Button(action: {
                        viewModel.action(.sendChat)
                    }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(.blackSeafoam)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray30, lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.white)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.gray30),
            alignment: .top
        )
    }
    
    private func scrollToBottom(proxy: ScrollViewProxy) {
        guard let lastMessage = viewModel.state.chatList.last else { return }
        
        Task { @MainActor in
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1초
            withAnimation(.easeInOut(duration: 0.3)) {
                proxy.scrollTo(lastMessage.chatId, anchor: UnitPoint.bottom)
            }
        }
    }
    
    private func maintainScrollPosition(proxy: ScrollViewProxy) {
        
        if viewModel.state.chatList.count > 20 {
            let targetIndex = min(20, viewModel.state.chatList.count - 1)
            
            if targetIndex < viewModel.state.chatList.count {
                Task { @MainActor in
                    try await Task.sleep(nanoseconds: 50_000_000) // 0.05초
                    proxy.scrollTo(viewModel.state.chatList[targetIndex].chatId, anchor: .top)
                }
            }
        }
    }
}


