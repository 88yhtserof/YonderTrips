//
//  ActivityListCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct ActivityListCellView: View {
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack {
                ZStack(alignment: .trailing) {
                    
                    DataImageView(urlString: "")
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Color.gray100.opacity(0.28)
                        }
                        .clipped()
                        .allowsHitTesting(false)
                    
                    VStack(alignment: .trailing) {
                        LocationTagView(country: "대한민국")
                        Spacer()
                        AdvertisementTagView(isAdvertisement: true)
                    }
                    .padding(16)
                    
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(25)
                
                ActivityTagView(tag: "NEW 오픈 특가")
                    .padding(.top, -25)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text("새싹 패러글라이딩 2기")
                        .font(.yt(.pretendard(.body1)))
                        .foregroundColor(.gray90)
                    
                    HStack(spacing: 2) {
                        
                        Image(.likeFill)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.lightSeafoam)
                        
                        Text("\(88)")
                            .font(.yt(.paperlogy(.caption2)))
                            .foregroundStyle(.gray60)
                    }
                    
                    HStack(spacing: 2) {
                        Image(.point)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.blackSeafoam)
                        
                        Text("\(88)P")
                            .font(.yt(.paperlogy(.caption2)))
                            .foregroundStyle(.gray60)
                    }
                }
                .padding(.top, 16)
                
                Text("두려움을 넘고, 하늘을 향한 두 번째 도전이 시작됩니다. 아직은 서툴지만, 하늘을 향한 마음은 누구보다 단단한 새싹들의 비상.")
                    .font(.yt(.pretendard(.caption1)))
                    .foregroundColor(.gray75)
                    .lineLimit(3)
                
                HStack {
                    HStack(spacing: 24) {
                        // TODO: - 금액 숫자 형식 적용
                        Text(String("\(12000)원"))
                            .font(.yt(.pretendard(.body1)))
                            .foregroundColor(.gray45)
                            .overlay {
                                Image(.arrow)
                                    .frame(height: 6)
                                    .padding(.trailing, -16)
                                    .foregroundStyle(.blackSeafoam)
                            }
                        Text(String("\(12000)원"))
                            .font(.yt(.pretendard(.body1)))
                            .foregroundColor(.gray90)
                    }
                    
                    Text(String("\(100)%"))
                        .font(.yt(.pretendard(.body1)))
                        .foregroundStyle(.blackSeafoam)
                    
                    Spacer()
                    
                    FavoriteButtonView {
                        print("FavoriteButtonView")
                    }
                    .contentShape(Rectangle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}


#Preview {
    ActivityListCellView()
}
