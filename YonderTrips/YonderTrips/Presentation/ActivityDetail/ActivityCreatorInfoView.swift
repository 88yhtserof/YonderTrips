//
//  ActivityCreatorInfoView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/16/25.
//

import SwiftUI

struct ActivityCreatorInfoView: View {
    
    let userInfo: UserInfo
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            SubheaderView(title: "판매자 정보")
            
            VStack(spacing: 16) {
                HStack {
                    DataImageView(urlString: userInfo.profileImage)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                        .clipShape(.circle)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(userInfo.nick)
                            .font(.yt(.pretendard(.caption1)))
                            .foregroundStyle(.gray90)
                        
                        Text(userInfo.introduction)
                            .font(.yt(.pretendard(.caption2)))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "ellipsis.message")
                    
                    Text("문의하기")
                        .font(.yt(.pretendard(.caption1)))
                }
                .foregroundStyle(.gray90)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray45, lineWidth: 1)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ActivityCreatorInfoView(userInfo: UserInfo(userId: "123456", nick: "파리리틀트립", profileImage: "https://example.com/profile.jpg", introduction: "파리에서 작은 여행을 즐기는 블로거입니다."))
}

