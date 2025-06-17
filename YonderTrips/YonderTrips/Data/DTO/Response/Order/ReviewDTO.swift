//
//  ReviewDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct ReviewDTO: Codable {
    let id: String
    let rating: Double
}

extension ReviewDTO {
    
    func toEntity() -> Review {
        return Review(id: id, rating: rating)
    }
}
