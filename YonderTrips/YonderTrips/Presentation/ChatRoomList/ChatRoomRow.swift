//
//  ChatRoomRow.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/29/25.
//

import SwiftUI

struct ChatRoomRow: View {
    let chatRoom: ChatRoomResponse
    let opponent: UserInfo
    
    var body: some View {
        HStack(spacing: 12) {
            profileImage
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(chatRoom.title)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if let lastChat = chatRoom.lastChat {
                        Text(formatTime(lastChat.createdAt))
                            .font(.caption)
                            .foregroundStyle(.gray60)
                    }
                }
                
                HStack {
                    if let lastChat = chatRoom.lastChat {
                        Text(lastChat.content)
                            .font(.body)
                            .foregroundStyle(.gray75)
                            .lineLimit(2)
                    } else {
                        Text("대화를 시작해보세요")
                            .font(.body)
                            .foregroundStyle(.gray60)
                            .lineLimit(1)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.white)
    }
    
    private var profileImage: some View {
        
        return Group {
            if !opponent.profileImage.isEmpty {
                DataImageView(urlString: opponent.profileImage)
                    .foregroundStyle(.gray)
                
            } else {
                Circle()
                    .fill(.gray30)
                    .overlay {
                        Text(opponent.nick.prefix(1).uppercased())
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray75)
                    }
            }
        }
        .frame(width: 56, height: 56)
        .clipShape(.circle)
    }
    
    private func formatTime(_ timeString: String) -> String {
        guard let date = YTDateFormatter.date(from: timeString, format: .iso8601UTC) else {
            return ""
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            return YTDateFormatter.string(from: date, format: .ahmm)
        } else if calendar.isDateInYesterday(date) {
            return "어제"
        } else if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
            return YTDateFormatter.string(from: date, format: .MMdd)
        } else {
            return YTDateFormatter.string(from: date, format: .yyyyMMdd)
        }
    }
}
