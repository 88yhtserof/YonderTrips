//
//  OrderResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct OrderResponseDTO: Decodable {
    let orderId: String
    let orderCode: String
    let totalPrice: Int
    let reservationItemName: String
    let reservationItemTime: String
    let participantCount: Int
    let activity: ActivitySummaryResponseDTO
    let paidAt: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case orderCode = "order_code"
        case totalPrice = "total_price"
        case reservationItemName = "reservation_item_name"
        case reservationItemTime = "reservation_item_time"
        case participantCount = "participant_count"
        case activity
        case paidAt
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try container.decode(String.self, forKey: .orderId)
        orderCode = try container.decode(String.self, forKey: .orderCode)
        totalPrice = try container.decode(Int.self, forKey: .totalPrice)
        reservationItemName = try container.decode(String.self, forKey: .reservationItemName)
        reservationItemTime = try container.decode(String.self, forKey: .reservationItemTime)
        participantCount = try container.decode(Int.self, forKey: .participantCount)
        activity = try container.decode(ActivitySummaryResponseDTO.self, forKey: .activity)
        paidAt = try container.decode(String.self, forKey: .paidAt)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
}

extension OrderResponseDTO {
    
    func toEntity() -> OrderResponse {
        return OrderResponse(
            orderId: orderId,
            orderCode: orderCode,
            totalPrice: totalPrice,
            reservationItemName: reservationItemName,
            reservationItemTime: reservationItemTime,
            participantCount: participantCount,
            activity: activity.toEntity(),
            paidAt: paidAt,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
