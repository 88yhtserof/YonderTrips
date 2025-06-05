//
//  PostSummaryPaginationResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/5/25.
//

import Foundation

struct PostSummaryPaginationResponseDTO: Decodable {
    let data: [PostSummaryResponseDTO]
    let nextCursor: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case nextCursor = "next_cursor"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeIfPresent([PostSummaryResponseDTO].self, forKey: .data) ?? []
        self.nextCursor = try container.decodeIfPresent(String.self, forKey: .nextCursor) ?? ""
    }
}

extension PostSummaryPaginationResponseDTO {
    
    func toEntity() -> PostSummaryPagination {
        PostSummaryPagination(
            data: data.map { $0.toEntity() },
            nextCursor: nextCursor
        )
    }
}
