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
    let paidAt: Date
    let createdAt: Date
    let updatedAt: Date
    
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
        
        let dateFormatter = ISO8601DateFormatter()
        let paidAtString = try container.decode(String.self, forKey: .paidAt)
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)
        
        guard let paidAt = dateFormatter.date(from: paidAtString),
              let createdAt = dateFormatter.date(from: createdAtString),
              let updatedAt = dateFormatter.date(from: updatedAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .paidAt, in: container, debugDescription: "Invalid date format")
        }
        
        self.paidAt = paidAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension OrderResponseDTO {
    
    func toEntity() -> Order {
        return Order(
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
