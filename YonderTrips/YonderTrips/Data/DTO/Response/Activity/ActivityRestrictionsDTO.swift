//
//  ActivityRestrictionsDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

struct ActivityRestrictionsDTO: Decodable {
    let minHeight: Int
    let minAge: Int
    let maxParticipants: Int
    
    enum CodingKeys: String, CodingKey {
        case minHeight = "min_height"
        case minAge = "min_age"
        case maxParticipants = "max_participants"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minHeight = try container.decodeIfPresent(Int.self, forKey: .minHeight) ?? 0
        self.minAge = try container.decodeIfPresent(Int.self, forKey: .minAge) ?? 0
        self.maxParticipants = try container.decodeIfPresent(Int.self, forKey: .maxParticipants) ?? 0
    }
}

extension ActivityRestrictionsDTO {
    
    func toEntity() -> ActivityRestrictions {
        ActivityRestrictions(
            minHeight: minHeight,
            minAge: minAge,
            maxParticipants: maxParticipants
        )
    }
}
