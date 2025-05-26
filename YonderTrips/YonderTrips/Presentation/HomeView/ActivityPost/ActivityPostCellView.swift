//
//  ActivityPostCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

struct ActivityPostCellView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Image("TripsPoster")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    Text("씩씩한 새싹이")
                        .font(.yt(.pretendard(.caption1)))
                    Text("1시간 34분 전")
                        .font(.yt(.pretendard(.caption2)))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            HStack(spacing: 5) {
                ZStack(alignment: .topLeading) {
                    Image("TripsPoster")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    FavoriteButtonView {
                        print("FavoriteButtonView")
                    }
                    
                    Image("PlayButton")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white.opacity(0.8))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                VStack(spacing: 5) {
                    Image("TripsPoster")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image("TripsPoster")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .padding(10)
            
            Text("타이페이 스노쿨링 여행")
                .font(.yt(.pretendard(.body3)))
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text("끝없이 펼쳐진 바다를 바라보며, 모든 고민이 잠시 멀어지는 느낌이였다. 천천한 파도 소리에 마음까지 편안해졌던 시간.")
                .font(.yt(.pretendard(.caption1)))
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            HStack {
                Button(action: {}) {
                    
                    HStack {
                        Image("Location")
                            .resizable()
                            .frame(width: 13, height: 13)
                        
                        Text("대만 타이페이")
                            .font(.yt(.pretendard(.caption1)))
                    }
                    .foregroundColor(.deepSeafoam)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(.gray15)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.lightSeafoam, lineWidth: 1)
                    }
                }
                
                
                Button(action: {}) {
                    
                    HStack {
                        Text("타이페이 스노쿨링 초보자 스쿨 2기")
                            .font(.yt(.pretendard(.caption1)))
                    }
                    .foregroundColor(.deepSeafoam)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(.gray15)
                    .cornerRadius(15)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.lightSeafoam, lineWidth: 1)
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .padding(8)
        .background(.gray0)
    }
}

//MARK: - Action
private extension ActivityPostCellView {
    
    
}
