//
//  ActivityReservationItemDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/1/25.
//


struct ActivityReservationItemDTO: Decodable {
    let itemName: String
    let times: [ActivityReservationTimeDTO]
    
    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case times
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.itemName = try container.decodeIfPresent(String.self, forKey: .itemName) ?? ""
        self.times = try container.decodeIfPresent([ActivityReservationTimeDTO].self, forKey: .times) ?? []
    }
}

extension ActivityReservationItemDTO {
    
    func toEntity() -> ActivityReservationItem {
        ActivityReservationItem(
            itemName: itemName,
            times: times.map { $0.toEntity() }
        )
    }
}
