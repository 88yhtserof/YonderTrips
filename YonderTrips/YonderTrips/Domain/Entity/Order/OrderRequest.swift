//
//  OrderRequest.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct OrderRequest {
    let activityId: String
    let reservationItemName: String
    let reservationItemTime: String
    let participantCount: Int
    let totalPrice: Int
}
