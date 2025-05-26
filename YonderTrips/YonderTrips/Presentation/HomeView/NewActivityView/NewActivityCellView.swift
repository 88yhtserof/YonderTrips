//
//  NewActivityCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import SwiftUI

struct NewActivityCellView: View {
    
    let item: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
                    Image(item) // 본인의 이미지 이름으로 교체하세요
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350)
                        .clipped()
                        .overlay {
                            Color.gray100.opacity(0.25)
                        }

                    VStack(alignment: .leading, spacing: 8) {
                        // 상단 태그
                        Text("✈️ 스위스 융프라우")
                            .font(.yt(.pretendard(.caption2)))
                            .foregroundColor(.gray0)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Capsule())

                        Spacer()

                        // 제목
                        Text("겨울 새싹 스키 원정대")
                            .font(.yt(.paperlogy(.title1)))
                            .foregroundColor(.gray0)

                        // 가격
                        Text("₩ 123,000원")
                            .font(.yt(.paperlogy(.caption1)))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray0)

                        // 설명
                        Text("끝없이 펼쳐진 슬로프, 자유롭게 바람을 가르는 시간. 초보자 코스부터 짜릿한 파크존까지, 당신만의 새싹 스키 리듬을 찾아 떠나보세요.")
                            .font(.yt(.pretendard(.caption1)))
                            .foregroundColor(.gray0)
                            .lineLimit(3)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 300, height: 350)
                .background(Color.black)
                .cornerRadius(25)
                .shadow(radius: 6)
                .padding(8)
    }
}

#Preview {
    NewActivityCellView(item: "TripsPoster")
}
