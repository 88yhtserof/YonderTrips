//
//  PostSummaryResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/5/25.
//

import Foundation

struct PostSummaryResponseDTO: Decodable {
    let postId: String
    let country: String
    let category: String
    let title: String
    let content: String
    let activity: ActivitySummaryResponseDTO_Post?
    let geolocation: ActivityGeolocationDTO
    let creator: UserInfoResponseDTO
    let files: [String]
    let isLike: Bool
    let likeCount: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case country
        case category
        case title
        case content
        case activity
        case geolocation
        case creator
        case files
        case isLike = "is_like"
        case likeCount = "like_count"
        case createdAt
        case updatedAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decodeIfPresent(String.self, forKey: .postId) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.content = try container.decodeIfPresent(String.self, forKey: .content) ?? ""
        self.activity = try container.decodeIfPresent(ActivitySummaryResponseDTO_Post.self, forKey: .activity)
        self.geolocation = try container.decodeIfPresent(ActivityGeolocationDTO.self, forKey: .geolocation) ?? ActivityGeolocationDTO(longitude: 0.0, latitude: 0.0)
        self.creator = try container.decodeIfPresent(UserInfoResponseDTO.self, forKey: .creator) ?? UserInfoResponseDTO(from: decoder)
        self.files = try container.decodeIfPresent([String].self, forKey: .files) ?? []
        self.isLike = try container.decodeIfPresent(Bool.self, forKey: .isLike) ?? false
        self.likeCount = try container.decodeIfPresent(Int.self, forKey: .likeCount) ?? 0
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
    }
}

extension PostSummaryResponseDTO {
    func toEntity() -> PostSummary {
        PostSummary(
            postId: postId,
            country: country,
            category: category,
            title: title,
            content: content,
            activity: activity?.toEntity(),
            geolocation: geolocation.toEntity(),
            creator: creator.toEntity(),
            files: files,
            isLike: isLike,
            likeCount: likeCount,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
