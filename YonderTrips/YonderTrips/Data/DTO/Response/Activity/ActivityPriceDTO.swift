//
//  ActivityPriceDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//


struct ActivityPriceDTO: Codable {
    let original: Int
    let final: Int
}

extension ActivityPriceDTO {
    
    func toEntity() -> ActivityPrice {
        ActivityPrice(
            original: original,
            final: final
        )
    }
}
