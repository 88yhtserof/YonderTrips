//
//  ActivitySummaryResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import Foundation

struct ActivitySummaryResponseDTO: Decodable {
    
    let activityId: String
    let title: String?
    let country: String?
    let category: String?
    let thumbnails: [String]
    let geolocation: ActivityGeolocationDTO
    let price: ActivityPriceDTO
    let tags: [String]
    let pointReward: Double?
    let isAdvertisement: Bool
    let isKeep: Bool
    let keepCount: Int
    
    enum CodingKeys: String, CodingKey {
        case activityId = "activity_id"
        case title
        case country
        case category
        case thumbnails
        case geolocation
        case price
        case tags
        case pointReward = "point_reward"
        case isAdvertisement = "is_advertisement"
        case isKeep = "is_keep"
        case keepCount = "keep_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activityId = try container.decodeIfPresent(String.self, forKey: .activityId) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.country = try container.decodeIfPresent(String.self, forKey: .country)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.thumbnails = try container.decodeIfPresent([String].self, forKey: .thumbnails) ?? []
        self.geolocation = try container.decodeIfPresent(ActivityGeolocationDTO.self, forKey: .geolocation) ?? ActivityGeolocationDTO(longitude: 0.0, latitude: 0.0)
        self.price = try container.decodeIfPresent(ActivityPriceDTO.self, forKey: .price) ?? ActivityPriceDTO(original: 0, final: 0)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        self.pointReward = try container.decodeIfPresent(Double.self, forKey: .pointReward)
        self.isAdvertisement = try container.decodeIfPresent(Bool.self, forKey: .isAdvertisement) ?? false
        self.isKeep = try container.decodeIfPresent(Bool.self, forKey: .isKeep) ?? false
        self.keepCount = try container.decodeIfPresent(Int.self, forKey: .keepCount) ?? 0
    }
}

struct ActivityGeolocationDTO: Decodable {
    let longitude: Double
    let latitude: Double
}

struct ActivityPriceDTO: Codable {
    let original: Int
    let final: Int
}
