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
