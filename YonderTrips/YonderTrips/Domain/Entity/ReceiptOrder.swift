//
//  ReceiptOrder.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct ReceiptOrder {
    let paymentId: String
    let orderItem: Order
    let createdAt: Date
    let updatedAt: Date
}
