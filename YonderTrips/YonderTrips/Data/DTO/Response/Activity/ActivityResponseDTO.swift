//
//  ActivityResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//

import Foundation

import Foundation

struct ActivityResponseDTO: Decodable {
    let activityId: String
    let title: String
    let country: String
    let category: String
    let thumbnails: [String]
    let geolocation: ActivityGeolocationDTO
    let startDate: String
    let endDate: String
    let price: ActivityPriceDTO
    let tags: [String]
    let pointReward: Int //Number
    let restrictions: ActivityRestrictionsDTO
    let description: String
    let isAdvertisement: Bool
    let isKeep: Bool
    let keepCount: Int
    let totalOrderCount: Int
    let schedule: [ActivityScheduleItemDTO]
    let reservationList: [ActivityReservationItemDTO]
    let creator: UserInfoResponseDTO
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case activityId = "activity_id"
        case title
        case country
        case category
        case thumbnails
        case geolocation
        case startDate = "start_date"
        case endDate = "end_date"
        case price
        case tags
        case pointReward = "point_reward"
        case restrictions
        case description
        case isAdvertisement = "is_advertisement"
        case isKeep = "is_keep"
        case keepCount = "keep_count"
        case totalOrderCount = "total_order_count"
        case schedule
        case reservationList = "reservation_list"
        case creator
        case createdAt
        case updatedAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.activityId = try container.decodeIfPresent(String.self, forKey: .activityId) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        self.thumbnails = try container.decodeIfPresent([String].self, forKey: .thumbnails) ?? []
        self.geolocation = try container.decodeIfPresent(ActivityGeolocationDTO.self, forKey: .geolocation) ?? ActivityGeolocationDTO(longitude: 0.0, latitude: 0.0)
        self.startDate = try container.decodeIfPresent(String.self, forKey: .startDate) ?? ""
        self.endDate = try container.decodeIfPresent(String.self, forKey: .endDate) ?? ""
        self.price = try container.decodeIfPresent(ActivityPriceDTO.self, forKey: .price) ?? ActivityPriceDTO(original: 0, final: 0)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        self.pointReward = try container.decodeIfPresent(Int.self, forKey: .pointReward) ?? 0
        self.restrictions = try container.decodeIfPresent(ActivityRestrictionsDTO.self, forKey: .restrictions) ?? ActivityRestrictionsDTO(from: decoder)
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.isAdvertisement = try container.decodeIfPresent(Bool.self, forKey: .isAdvertisement) ?? false
        self.isKeep = try container.decodeIfPresent(Bool.self, forKey: .isKeep) ?? false
        self.keepCount = try container.decodeIfPresent(Int.self, forKey: .keepCount) ?? 0
        self.totalOrderCount = try container.decodeIfPresent(Int.self, forKey: .totalOrderCount) ?? 0
        self.schedule = try container.decodeIfPresent([ActivityScheduleItemDTO].self, forKey: .schedule) ?? []
        self.reservationList = try container.decodeIfPresent([ActivityReservationItemDTO].self, forKey: .reservationList) ?? []
        self.creator = try container.decodeIfPresent(UserInfoResponseDTO.self, forKey: .creator) ?? UserInfoResponseDTO(from: decoder)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt) ?? ""
    }
}

extension ActivityResponseDTO {
    
      func toEntity() -> Activity {
          Activity(
              activityId: activityId,
              title: title,
              country: country,
              category: category,
              thumbnails: thumbnails,
              geolocation: geolocation.toEntity(),
              startDate: startDate,
              endDate: endDate,
              price: price.toEntity(),
              tags: tags,
              pointReward: pointReward,
              restrictions: restrictions.toEntity(),
              description: description,
              isAdvertisement: isAdvertisement,
              isKeep: isKeep,
              keepCount: keepCount,
              totalOrderCount: totalOrderCount,
              schedule: schedule.map { $0.toEntity() },
              reservationList: reservationList.map { $0.toEntity() },
              creator: creator.toEntity(),
              createdAt: createdAt,
              updatedAt: updatedAt
          )
      }
}
