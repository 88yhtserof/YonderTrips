//
//  PostSummary+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/23/25.
//

import Foundation

extension PostSummary {
    
    static let dummyData: [PostSummary] = [
        PostSummary(
            postId: "post_001",
            country: "South Korea",
            category: "Adventure",
            title: "Jeju Island Coastal Trek",
            content: "Walked along the stunning Olle Trail in Jeju, breathtaking views!",
            activity: ActivitySummary_Post(
                id: "act_001",
                title: "Jeju Olle Trail Tour",
                country: "South Korea",
                category: "Hiking",
                thumbnails: ["jeju_olle1.jpg", "jeju_olle2.jpg"],
                geolocation: ActivityGeolocation(longitude: 126.4981, latitude: 33.4890),
                price: ActivityPrice(original: 80000, final: 72000),
                tags: ["hiking", "coastal", "nature"],
                pointReward: 15.0,
                isAdvertisement: false,
                isKeep: true,
                keepCount: 40
            ),
            geolocation: ActivityGeolocation(longitude: 126.4981, latitude: 33.4890),
            creator: UserInfo(
                userId: "user_001",
                nick: "IslandHiker",
                profileImage: "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg",
                introduction: "Exploring the natural beauty of islands"
            ),
            files: [
                "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg"
            ],
            isLike: true,
            likeCount: 210,
            createdAt: "2025-06-23T14:00:00Z",
            updatedAt: "2025-06-23T14:00:00Z"
        ),
        PostSummary(
            postId: "post_002",
            country: "Thailand",
            category: "Food",
            title: "Bangkok Street Food Tour",
            content: "Tasted spicy som tam and mango sticky rice, so delicious!",
            activity: nil,
            geolocation: ActivityGeolocation(longitude: 100.5018, latitude: 13.7563),
            creator: UserInfo(
                userId: "user_002",
                nick: "SpiceLover",
                profileImage: "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg",
                introduction: "Chasing bold flavors around the globe"
            ),
            files: [
                "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg",
                "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg",
                "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg"
            ],
            isLike: false,
            likeCount: 110,
            createdAt: "2025-06-22T18:30:00Z",
            updatedAt: "2025-06-22T18:30:00Z"
        ),
        PostSummary(
            postId: "post_003",
            country: "Spain",
            category: "Culture",
            title: "Flamenco Night in Seville",
            content: "Experienced an authentic flamenco performance, so passionate!",
            activity: ActivitySummary_Post(
                id: "act_002",
                title: "Seville Flamenco Show",
                country: "Spain",
                category: "Performance",
                thumbnails: ["flamenco1.jpg", "flamenco2.jpg"],
                geolocation: ActivityGeolocation(longitude: -5.9845, latitude: 37.3886),
                price: ActivityPrice(original: 50, final: 45),
                tags: ["flamenco", "culture", "dance"],
                pointReward: 10.0,
                isAdvertisement: true,
                isKeep: false,
                keepCount: 20
            ),
            geolocation: ActivityGeolocation(longitude: -5.9845, latitude: 37.3886),
            creator: UserInfo(
                userId: "user_003",
                nick: "CultureSeeker",
                profileImage: "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg",
                introduction: "Immersed in global cultures and traditions"
            ),
            files: [
                "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg",
                "/data/activities/KakaoTalk_Photo_2025-06-07-17-18-19 001_1749284344177.jpeg"
            ],
            isLike: true,
            likeCount: 320,
            createdAt: "2025-06-21T20:15:00Z",
            updatedAt: "2025-06-21T20:15:00Z"
        )
    ]
}
