//
//  ReceiptOrderResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct ReceiptOrderResponseDTO: Decodable {
    let paymentId: String
    let orderItem: OrderResponseDTO
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case paymentId = "payment_id"
        case orderItem = "order_item"
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        paymentId = try container.decode(String.self, forKey: .paymentId)
        orderItem = try container.decode(OrderResponseDTO.self, forKey: .orderItem)
        
        let dateFormatter = ISO8601DateFormatter()
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)
        
        guard let createdAt = dateFormatter.date(from: createdAtString),
              let updatedAt = dateFormatter.date(from: updatedAtString) else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt, in: container, debugDescription: "Invalid date format")
        }
        
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension ReceiptOrderResponseDTO {
    
    func toEntity() -> ReceiptOrder {
        return ReceiptOrder(
            paymentId: paymentId,
            orderItem: orderItem.toEntity(),
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
