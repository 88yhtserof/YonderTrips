//
//  ActivityScheduleItemDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

struct ActivityScheduleItemDTO: Decodable {
    let duration: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case duration
        case description
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    }
}

extension ActivityScheduleItemDTO {
    
    func toEntity() -> ActivityScheduleItem {
        ActivityScheduleItem(
            duration: duration,
            description: description
        )
    }
}
