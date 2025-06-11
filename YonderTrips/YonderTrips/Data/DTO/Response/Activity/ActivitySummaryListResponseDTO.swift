//
//  ActivitySummaryListResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import Foundation

struct ActivitySummaryListResponseDTO: Decodable {
    let data: [ActivitySummaryResponseDTO]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([ActivitySummaryResponseDTO].self, forKey: .data) ?? []
        nextCursor = try container.decodeIfPresent(String.self, forKey: .nextCursor) ?? ""
    }
}
