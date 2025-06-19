//
//  YTDateFormatter.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import Foundation

struct YTDateFormatter {
    
    enum Format {
        case iso8601
        case yyyyMMdd
    }
    
    static private let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    static private let yyyyMMddFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static func string(from date: Date, format: Format) -> String {
        
        switch format {
        case .iso8601:
            return iso8601Formatter.string(from: date)
        case .yyyyMMdd:
            return yyyyMMddFormatter.string(from: date)
        }
    }
    
    static func date(from string: String, format: Format) -> Date? {
        
        switch format {
        case .iso8601:
            return iso8601Formatter.date(from: string)
        case .yyyyMMdd:
            return yyyyMMddFormatter.date(from: string)
        }
    }
}
