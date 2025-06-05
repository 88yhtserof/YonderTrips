//
//  PostSummary.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/5/25.
//

import Foundation

struct PostSummary {
    let postId: String
    let country: String
    let category: String
    let title: String
    let content: String
    let activity: ActivitySummary_Post?
    let geolocation: ActivityGeolocation
    let creator: UserInfo
    let files: [String]
    let isLike: Bool
    let likeCount: Int
    let createdAt: String
    let updatedAt: String
}
