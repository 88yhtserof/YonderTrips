//
//  ActivityPostCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

struct ActivityPostCellView: View {
    
    private let postSummary: PostSummary
    
    init(postSummary: PostSummary) {
        self.postSummary = postSummary
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                DataImageView(urlString: postSummary.creator.profileImage)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)
                    .clipShape(.circle)
                
                // TODO: - 게시글 업로드 시간 계산 및 적용
                VStack(alignment: .leading) {
                    Text(postSummary.creator.nick)
                        .font(.yt(.pretendard(.caption1)))
                    Text("1시간 34분 전")
                        .font(.yt(.pretendard(.caption2)))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            thumbnailImage(with: postSummary.files)
            
            Text(postSummary.title)
                .font(.yt(.pretendard(.body3)))
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text(postSummary.content)
                .font(.yt(.pretendard(.caption1)))
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            HStack {
                Button(action: {}) {
                    
                    HStack {
                        Image(.location)
                            .resizable()
                            .frame(width: 13, height: 13)
                        
                        Text(postSummary.country)
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
                        Text(postSummary.activity?.title ?? "")
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
                
                // TODO: - Favorite 데이터 상태 반영
                HStack(spacing: 2) {
                    FavoriteButtonView {
                        print("FavoriteButtonView")
                    }
                    
                    Text("\(postSummary.likeCount)")
                        .font(.yt(.paperlogy(.caption2)))
                        .foregroundStyle(.gray60)
                }
            }
            .padding(.horizontal)
        }
        .padding(8)
        .background(.gray0)
    }
}

//MARK: - View
private extension ActivityPostCellView {
    
    
    @ViewBuilder
    func thumbnailImage(with files: [String]) -> some View {
        
        switch files.count {
        case 0:
            EmptyView()
        case 1:
            DataImageView(urlString: files[0])
                .frame(height: 205)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(10)
        case 2:
            HStack(spacing: 5) {
                DataImageView(urlString: files[0])
                    .frame(height: 205)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                DataImageView(urlString: files[1])
                    .frame(height: 205)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(10)
        case 3...:
            HStack(spacing: 5) {
                DataImageView(urlString: files[0])
                    .frame(height: 205)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                VStack(spacing: 5) {
                    DataImageView(urlString: files[1])
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    DataImageView(urlString: files[2])
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .padding(10)
        default:
            EmptyView()
        }
    }
}
