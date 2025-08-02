//
//  PayloadDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/30/25.
//

import Foundation

struct PayloadDTO: Decodable {
    let type: String
    let value: String
}

extension PayloadDTO {
    
    func toEntity() -> BannerPayload {
        return BannerPayload (type: type, value: value)
    }
}
