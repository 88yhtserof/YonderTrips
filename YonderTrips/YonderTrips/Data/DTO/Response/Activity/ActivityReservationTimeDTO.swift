//
//  ActivityReservationTimeDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

struct ActivityReservationTimeDTO: Decodable {
    let time: String
    let isReserved: Bool
    
    enum CodingKeys: String, CodingKey {
        case time
        case isReserved = "is_reserved"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        self.isReserved = try container.decodeIfPresent(Bool.self, forKey: .isReserved) ?? false
    }
}

extension ActivityReservationTimeDTO {
    
    func toEntity() -> ActivityReservationTime {
        ActivityReservationTime(
            time: time,
            isReserved: isReserved
        )
    }
}
