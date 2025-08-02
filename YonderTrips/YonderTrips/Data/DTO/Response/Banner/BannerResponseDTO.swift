//
//  BannerResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/30/25.
//

import Foundation

struct BannerResponseDTO: Decodable {
    let name: String
    let imageUrl: String
    let payload: PayloadDTO
}

extension BannerResponseDTO {
    
    func toEntity() -> BannerItem {
        BannerItem(
            name: self.name,
            imageUrl: self.imageUrl,
            payload: BannerPayload(
                type: self.payload.type,
                value: self.payload.value
            )
        )
    }
}
