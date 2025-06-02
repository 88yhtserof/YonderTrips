//
//  NewActivityCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import SwiftUI

struct NewActivityCellView: View {
    
    let item: Activity
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // TODO: - request image with headers
            AsyncImage(url: URL(string: item.thumbnails.first ?? "")) { phase in
                switch phase {
                case .empty:
                    Color.gray45
                        .frame(height: 350)
                        .clipped()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350)
                        .clipped()
                        .overlay {
                            Color.gray100.opacity(0.25)
                        }
                case .failure:
                    Color.gray45
                        .frame(height: 350)
                        .clipped()
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.white)
                        )
                @unknown default:
                    Color.gray45
                        .frame(height: 350)
                        .clipped()
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Image(.location)
                        .resizable()
                        .frame(width: 13, height: 13)
                    
                    Text(item.country)
                        .font(.yt(.pretendard(.caption2)))
                }
                .foregroundColor(.gray0)
                .padding(.vertical, 3)
                .padding(.horizontal, 10)
                .background(.gray0.opacity(0.3))
                .cornerRadius(15)
                
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

