//
//  Order.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct Order {
    let orderId: String
    let orderCode: String
    let totalPrice: Int
    let reservationItemName: String
    let reservationItemTime: String
    let participantCount: Int
    let activity: ActivitySummary
    let paidAt: Date
    let createdAt: Date
    let updatedAt: Date
}
