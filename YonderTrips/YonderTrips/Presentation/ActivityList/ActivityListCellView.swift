//
//  ActivityListCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct ActivityListCellView: View {
    
    let activity: Activity
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack {
                ZStack(alignment: .trailing) {
                    
                    DataImageView(urlString: activity.imageThumbnail)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Color.gray100.opacity(0.28)
                        }
                    
                    VStack(alignment: .trailing) {
                        LocationTagView(country: activity.country)
                        Spacer()
                        
                        if activity.isAdvertisement {
                            AdvertisementTagView()
                        }
                    }
                    .padding(16)
                    
                }
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(25)
                
                if !activity.tags.isEmpty,
                   let tag = activity.tags.first {
                    ActivityTagView(tag: tag)
                        .padding(.top, -25)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text(activity.title)
                        .font(.yt(.pretendard(.body1)))
                        .foregroundColor(.gray90)
                    
                    HStack(spacing: 2) {
                        
                        Image(.likeFill)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.lightSeafoam)
                        
                        Text("\(activity.keepCount)")
                            .font(.yt(.paperlogy(.caption2)))
                            .foregroundStyle(.gray60)
                    }
                    
                    PointRewardTextView(pointReward: activity.pointReward)
                }
                .padding(.top, 16)
                
                Text(activity.description)
                    .font(.yt(.pretendard(.caption1)))
                    .foregroundColor(.gray75)
                    .lineLimit(3)
                
                HStack {
                    HStack(spacing: 24) {
                        // TODO: - 금액 숫자 형식 적용
                        Text(String("\(activity.price.original)원"))
                            .font(.yt(.pretendard(.body1)))
                            .foregroundColor(.gray45)
                            .overlay {
                                Image(.arrow)
                                    .frame(height: 6)
                                    .padding(.trailing, -16)
                                    .foregroundStyle(.blackSeafoam)
                            }
                        Text(String("\(activity.price.final)원"))
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
