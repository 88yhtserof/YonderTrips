//
//  ActivityReservationItem.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

struct ActivityReservationItem: Hashable {
    let itemName: String
    let times: [ActivityReservationTime]
}

extension ActivityReservationItem {
    
    var itemDate: Date? {
        YTDateFormatter.date(from: itemName, format: .yyyyMMdd)
    }
    
    var isFullyReserved: Bool {
        times.first{ !$0.isReserved } == nil
    }
}
