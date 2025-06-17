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
    let createdAt: String
    let updatedAt: String
    
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
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
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
