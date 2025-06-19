//
//  NewActivityCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import SwiftUI

struct NewActivityCellView: View {
    
    @EnvironmentObject private var homeRouter: HomeFlowRouter
    
    let item: Activity
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            DataImageView(urlString: item.imageThumbnail)
                .frame(width: 300, height: 350)
                .overlay {
                    Color.gray100.opacity(0.28)
                        .onTapGesture {
                            homeRouter.path.append(HomeFlowRouter.HomeFlow.activityDetail)
                        }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                
                LocationTagView(country: item.country)
                
                Spacer()
                
                Text(item.title)
                    .font(.yt(.paperlogy(.title1)))
                    .foregroundColor(.gray0)
                
                HStack {
                    Image(.won)
                        .resizable()
                        .frame(width: 13, height: 13)
                    
                    // TODO: - 금액 숫자 형식 적용
                    Text(String(item.price.final))
                        .font(.yt(.paperlogy(.caption1)))
                        .fontWeight(.semibold)
                }
                .foregroundColor(.gray0)
                
                Text(item.description)
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
        .shadow(radius: 3)
    }
}

