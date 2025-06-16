//
//  ListResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

struct ListResponseDTO<Response: Decodable>: Decodable {
    
    let data: [Response]
    
    enum CodingKeys: CodingKey {
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<ListResponseDTO<Response>.CodingKeys> = try decoder.container(keyedBy: ListResponseDTO<Response>.CodingKeys.self)
        self.data = try container.decodeIfPresent([Response].self, forKey: ListResponseDTO<Response>.CodingKeys.data) ?? []
    }
}
