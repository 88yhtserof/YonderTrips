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
        case iso8601UTC
        case yyyyMMdd
        case ahmm
    }
    
    static private let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    static private let iso8601UTCFormatter: ISO8601DateFormatter = {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormatter
    }()
    
    static private let yyyyMMddFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static private let ahmm: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        return formatter
    }()
    
    static func string(from date: Date, format: Format) -> String {
        
        switch format {
        case .iso8601:
            return iso8601Formatter.string(from: date)
        case .iso8601UTC:
            return iso8601UTCFormatter.string(from: date)
        case .yyyyMMdd:
            return yyyyMMddFormatter.string(from: date)
        case .ahmm:
            return ahmm.string(from: date)
        }
    }
    
    static func date(from string: String, format: Format) -> Date? {
        
        switch format {
        case .iso8601:
            return iso8601Formatter.date(from: string)
        case .iso8601UTC:
            return iso8601UTCFormatter.date(from: string)
        case .yyyyMMdd:
            return yyyyMMddFormatter.date(from: string)
        case .ahmm:
            return ahmm.date(from: string)
        }
    }
}
