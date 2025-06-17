//
//  OrderUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct OrderUseCase {
    
    func requestOrderCreate(with order: OrderRequest) async throws -> OrderCreate {
        let orderRequestDTO = OrderRequestDTO(
            activityId: order.activityId,
            reservationItemName: order.reservationItemName,
            reservationItemTime: order.reservationItemTime,
            participantCount: order.participantCount,
            totalPrice: order.totalPrice
        )
        
        let response: OrderCreateResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .order(.orderCreate(orderRequestDTO)))
        return response.toEntity()
    }
}
