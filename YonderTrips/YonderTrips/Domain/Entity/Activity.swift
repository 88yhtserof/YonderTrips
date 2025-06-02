//
//  Activity.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

struct Activity: Hashable {
    let activityId: String
    let title: String
    let country: String
    let category: String
    let thumbnails: [String]
    let geolocation: ActivityGeolocation
    let startDate: String
    let endDate: String
    let price: ActivityPrice
    let tags: [String]
    let pointReward: Int
    let restrictions: ActivityRestrictions?
    let description: String
    let isAdvertisement: Bool
    let isKeep: Bool
    let keepCount: Int
    let totalOrderCount: Int
    let schedule: [ActivityScheduleItem]
    let reservationList: [ActivityReservationItem]
    let creator: UserInfo?
    let createdAt: String
    let updatedAt: String
}
