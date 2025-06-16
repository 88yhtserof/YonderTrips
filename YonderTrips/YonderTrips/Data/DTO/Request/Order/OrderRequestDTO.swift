//
//  OrderRequestDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/15/25.
//

import Foundation

struct OrderRequestDTO: Encodable {
    let activityId: String
    let reservationItemName: String
    let reservationItemTime: String
    let participantCount: Int
    let totalPrice: Int
    
    enum CodingKeys: String, CodingKey {
        case activityId = "activity_id"
        case reservationItemName = "reservation_item_name"
        case reservationItemTime = "reservation_item_time"
        case participantCount = "participant_count"
        case totalPrice = "total_price"
    }
}

extension OrderRequestDTO {
    
    func toEntity() -> OrderRequest {
        return OrderRequest(
            activityId: self.activityId,
            reservationItemName: self.reservationItemName,
            reservationItemTime: self.reservationItemTime,
            participantCount: self.participantCount,
            totalPrice: self.totalPrice
        )
    }
}
