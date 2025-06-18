//
//  ActivityDetail.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct ActivityDetail: View {
    
    var body: some View {
        
        ScrollView {
            VStack {
                ZStack {
                    Image(.tripsPoster)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.gray15, location: 0.15),
                            .init(color: Color.clear, location: 0.65)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    activityDetailInfoView()
                        .padding(.top, -200)
                    
                    restrictionInfoView()
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .center)
                    
                    priceInfoView()
                    
                }
                .padding(20)
                
                ActivityCurriculumView()
            }
        }
        .background(.gray15)
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButtonView {
                    print("Keep")
                }
            }
        }
    }
}

//MARK: - View
extension ActivityDetail {
    
    func activityDetailInfoView() -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text("겨울 스키 원정대")
                .font(.yt(.paperlogy(.title1)))
                .foregroundStyle(.gray90)
            
            HStack(spacing: 12) {
                Text("스위스")
                    .font(.yt(.pretendard(.body1)).weight(.bold))
                    .foregroundStyle(.gray60)
                PointRewardTextView(pointReward: 200)
            }
            
            Text("""
                 끝없이 펼쳐진 슬로프 위에서, 자유롭게 바람을 가르는 짜릿한 시간.
                 눈부신 설경 속에서 넘어지고, 웃고, 다시 일어서며
                 당신만의 새싹 스키 리듬을 찾아 떠나보세요.
                 작은 도전들이 쌓여 어느새 자유롭게 슬로프를 누비는
                 순간을 만날 수 있을 거예요.
                 """)
            .font(.yt(.pretendard(.caption1)))
            .foregroundStyle(.gray60)
            .lineSpacing(6)
            
            HStack {
                activityTotalCountView(.buy, "누적 구매", 135)
                activityTotalCountView(.keepFill, "KEEP", 378)
            }
        }
    }
    
    func activityTotalCountView(_ imageResource: ImageResource, _ title: String, _ count: Int) -> some View {
        
        HStack(spacing: 2) {
            Image(imageResource)
                .resizable()
                .frame(width: 16, height: 16)
            
            Text(title)
                .font(.yt(.pretendard(.body3)))
            
            Text("\(count)회")
                .font(.yt(.pretendard(.body3)))
        }
        .foregroundStyle(.gray45)
    }
    
    func restrictionInfoView() -> some View {
        
        HStack(spacing: 20) {
            restrictionInfoDetailView(.age, "연령 제한", "18세")
            restrictionInfoDetailView(.height, "신장 제한", "150cm")
            restrictionInfoDetailView(.people, "최대 참가 인원", "20명")
        }
        .padding()
        .background(.gray0)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray30, lineWidth: 0.6)
        }
    }
    
    func restrictionInfoDetailView(_ imageResource: ImageResource, _ title: String, _ value: String) -> some View {
        
        HStack {
            Image(imageResource)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(8)
                .foregroundStyle(.gray60)
                .background(.gray15)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.gray45)
                    .font(.yt(.pretendard(.caption2)))
                
                Text(value)
                    .foregroundStyle(.gray75)
                    .font(.yt(.pretendard(.body3)))
            }
        }
    }
    
    func priceInfoView() -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("341,000원")
                .foregroundStyle(.gray45)
                .font(.yt(.paperlogy(.caption1)))
                .overlay {
                    HStack {
                        Image(.line)
                            .frame(height: 16)
                            .padding(.trailing, -25)
                            .foregroundStyle(.blackSeafoam)
                    }
                    .padding(.top, 13)
                }
            
            HStack(spacing: 8) {
                Text("판매가")
                    .foregroundStyle(.gray45)
                    .font(.yt(.paperlogy(.body1)))
                
                Text("123,000원")
                    .foregroundStyle(.gray75)
                    .font(.yt(.paperlogy(.body1)))
                
                Text("63%")
                    .foregroundStyle(.blackSeafoam)
                    .font(.yt(.paperlogy(.body1)))
            }
        }
    }
}

#Preview {
    ActivityDetail()
}
