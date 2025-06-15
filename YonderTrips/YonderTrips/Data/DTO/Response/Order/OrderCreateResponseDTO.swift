//
//  OrderCreateResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/15/25.
//

import Foundation

struct OrderCreateResponseDTO: Decodable {
    let orderId: String
    let orderCode: String
    let totalPrice: Int
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case orderCode = "order_code"
        case totalPrice = "total_price"
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try container.decode(String.self, forKey: .orderId)
        orderCode = try container.decode(String.self, forKey: .orderCode)
        totalPrice = try container.decode(Int.self, forKey: .totalPrice)
        
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

extension OrderCreateResponseDTO {
    
    func toEntity() -> OrderCreate {
        return OrderCreate(
            orderId: self.orderId,
            orderCode: self.orderCode,
            totalPrice: self.totalPrice,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
}
