//
//  ActivitySummary_Post.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/5/25.
//

import Foundation

struct ActivitySummary_Post {
    let id: String
    let title: String
    let country: String
    let category: String
    let thumbnails: [String]
    let geolocation: ActivityGeolocation
    let price: ActivityPrice
    let tags: [String]
    let pointReward: Double
    let isAdvertisement: Bool
    let isKeep: Bool
    let keepCount: Int
}
