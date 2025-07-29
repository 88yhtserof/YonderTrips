//
//  ChatRoomListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/28/25.
//


import SwiftUI

struct ChatRoomListView: View {
    @ObservedObject var viewModel: ChatRoomListViewModel
    @EnvironmentObject private var homeRouter: HomeFlowRouter
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModel.state.chatRoomList.isEmpty {
                emptyStateView
            } else {
                chatRoomListView
            }
        }
        .background(.gray15)
        .navigationTitle("채팅")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            viewModel.action(.onAppear)
        }
    }
    
    // MARK: - Chat Room List
    private var chatRoomListView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.state.chatRoomList, id: \.roomId) { chatRoom in
                    
                    chatRoomListRowButton(with: chatRoom)
                    
                    if chatRoom.roomId != viewModel.state.chatRoomList.last?.roomId {
                        Divider()
                            .background(.gray30)
                            .padding(.leading, 72)
                    }
                }
            }
        }
        .background(.white)
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "message.circle")
                .font(.system(size: 64))
                .foregroundColor(.gray60)
            
            Text("아직 채팅방이 없어요")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.gray75)
            
            Text("새로운 사람들과 대화를 시작해보세요")
                .font(.body)
                .foregroundColor(.gray60)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray15)
    }
    
    func chatRoomListRowButton(with chatRoom: ChatRoomResponse) -> some View {
        
        VStack {
            if let opponent = getOpponent(from: chatRoom.participants) {
                Button {
                    homeRouter.path.append(HomeFlowRouter.HomeFlow.chat(opponent.userId))
                } label: {
                    ChatRoomRow(chatRoom: chatRoom, opponent: opponent)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Text("알 수 없는 사용자 입니다.")
                    .foregroundStyle(.gray75)
                    .font(.yt(.pretendard(.body1)))
            }
        }
    }
}

//MARK: - Functions
private extension ChatRoomListView {
    
    private func getOpponent(from participants: [UserInfo]) -> UserInfo? {
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        return participants.first{ $0.userId != userId }
    }
}

