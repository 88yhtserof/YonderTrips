//
//  ActivityReservationItem+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import Foundation

extension ActivityReservationItem {
    
    static let dummyData: [ActivityReservationItem] = [
        ActivityReservationItem(
            itemName: "2025-07-01",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: true),
                ActivityReservationTime(time: "11:00", isReserved: true),
                ActivityReservationTime(time: "12:00", isReserved: true),
                ActivityReservationTime(time: "13:00", isReserved: true),
                ActivityReservationTime(time: "14:00", isReserved: true),
                ActivityReservationTime(time: "15:00", isReserved: true),
                ActivityReservationTime(time: "16:00", isReserved: true),
                ActivityReservationTime(time: "17:00", isReserved: true)
            ]
        ),
        ActivityReservationItem(
            itemName: "2025-07-02",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: false),
                ActivityReservationTime(time: "11:00", isReserved: true),
                ActivityReservationTime(time: "12:00", isReserved: false),
                ActivityReservationTime(time: "13:00", isReserved: false),
                ActivityReservationTime(time: "14:00", isReserved: false),
                ActivityReservationTime(time: "15:00", isReserved: false),
                ActivityReservationTime(time: "16:00", isReserved: false),
                ActivityReservationTime(time: "17:00", isReserved: false)
            ]
        ),
        ActivityReservationItem(
            itemName: "2025-07-03",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: false),
                ActivityReservationTime(time: "11:00", isReserved: false),
                ActivityReservationTime(time: "12:00", isReserved: false),
                ActivityReservationTime(time: "13:00", isReserved: false),
                ActivityReservationTime(time: "14:00", isReserved: false),
                ActivityReservationTime(time: "15:00", isReserved: false),
                ActivityReservationTime(time: "16:00", isReserved: false),
                ActivityReservationTime(time: "17:00", isReserved: false)
            ]
        ),
        ActivityReservationItem(
            itemName: "2025-07-04",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: false),
                ActivityReservationTime(time: "11:00", isReserved: false),
                ActivityReservationTime(time: "12:00", isReserved: false),
                ActivityReservationTime(time: "13:00", isReserved: false),
                ActivityReservationTime(time: "14:00", isReserved: false),
                ActivityReservationTime(time: "15:00", isReserved: false),
                ActivityReservationTime(time: "16:00", isReserved: false),
                ActivityReservationTime(time: "17:00", isReserved: false)
            ]
        ),
        ActivityReservationItem(
            itemName: "2025-07-05",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: false),
                ActivityReservationTime(time: "11:00", isReserved: false),
                ActivityReservationTime(time: "12:00", isReserved: false),
                ActivityReservationTime(time: "13:00", isReserved: false),
                ActivityReservationTime(time: "14:00", isReserved: false),
                ActivityReservationTime(time: "15:00", isReserved: false),
                ActivityReservationTime(time: "16:00", isReserved: false),
                ActivityReservationTime(time: "17:00", isReserved: false)
            ]
        ),
        ActivityReservationItem(
            itemName: "2025-07-06",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: false),
                ActivityReservationTime(time: "11:00", isReserved: false),
                ActivityReservationTime(time: "12:00", isReserved: false),
                ActivityReservationTime(time: "13:00", isReserved: false),
                ActivityReservationTime(time: "14:00", isReserved: false),
                ActivityReservationTime(time: "15:00", isReserved: false),
                ActivityReservationTime(time: "16:00", isReserved: false),
                ActivityReservationTime(time: "17:00", isReserved: false)
            ]
        ),
        ActivityReservationItem(
            itemName: "2025-07-07",
            times: [
                ActivityReservationTime(time: "10:00", isReserved: false),
                ActivityReservationTime(time: "11:00", isReserved: false),
                ActivityReservationTime(time: "12:00", isReserved: false),
                ActivityReservationTime(time: "13:00", isReserved: false),
                ActivityReservationTime(time: "14:00", isReserved: false),
                ActivityReservationTime(time: "15:00", isReserved: false),
                ActivityReservationTime(time: "16:00", isReserved: false),
                ActivityReservationTime(time: "17:00", isReserved: false)
            ]
        )
    ]
}
