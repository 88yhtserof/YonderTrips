//
//  ChatMessageRow.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/15/25.
//

import SwiftUI

struct ChatMessageRow: View {
    let chat: ChatResponse
    
    var body: some View {
        HStack {
            if chat.isMyMessage {
                Spacer()
                myMessageBubble
            } else {
                otherMessageBubble
                Spacer()
            }
        }
    }
    
    private var myMessageBubble: some View {
        VStack(alignment: .trailing, spacing: 4) {
            HStack {
                Text(formatTime(chat.createdAt))
                    .font(.yt(.pretendard(.caption1)))
                    .foregroundColor(.secondary)
                
                Text(chat.content)
                    .font(.yt(.pretendard(.body1)))
                    .foregroundColor(.gray90)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.lightSeafoam)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
    }
    
    private var otherMessageBubble: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(chat.content)
                        .font(.yt(.pretendard(.body1)))
                        .foregroundColor(.gray90)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(16)
                    
                    Text(formatTime(chat.createdAt))
                        .font(.yt(.pretendard(.caption1)))
                        .foregroundColor(.gray45)
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
    }
    
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        
        guard let date = YTDateFormatter.date(from: timeString, format: .iso8601UTC) else {
            return ""
        }
        return YTDateFormatter.string(from: date, format: .ahmm)
    }
}
