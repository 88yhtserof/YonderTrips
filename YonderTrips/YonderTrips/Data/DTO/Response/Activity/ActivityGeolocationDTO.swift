//
//  ActivityGeolocationDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

struct ActivityGeolocationDTO: Decodable {
    let longitude: Double
    let latitude: Double
}

extension ActivityGeolocationDTO {
    
    func toEntity() -> ActivityGeolocation {
        ActivityGeolocation(
            longitude: longitude,
            latitude: latitude
        )
    }
}
