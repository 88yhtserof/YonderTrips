//
//  YonderTripsLogger.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation
import os.log

class YonderTripsLogger: Logging {
    
    static let shared = YonderTripsLogger(category: "default")
    
    private let logger: Logger
    
    private init(subsystem: String = "com.example.YonderTrips-Practice",
         category: String) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
    
    func log(_ message: String,
             type: OSLogType,
             file: String = #file,
             line: Int = #line) {
        
        let level = LogLevel(rawValue: type)
        let log = logMessage(message, level: level)
        logger.log(level: type, "\(log)")
    }
    
    func error(_ error: LocalizedError,
               file: String = #file,
               line: Int = #line) {
        
        let level = LogLevel(rawValue: .error)
        let log = logMessage(error, level: level)
        logger.log(level: .error, "\(log)")
    }
}

private extension YonderTripsLogger {
    
    enum LogLevel: String {
        case debug, info, notice, error, fault
        
        init(rawValue: OSLogType) {
            switch rawValue {
            case .debug: self = .debug
            case .default: self = .notice
            case .error: self = .error
            case .fault: self = .fault
            case .info: self = .info
            default: self = .debug
            }
        }
        
        var title: String {
            self.rawValue.uppercased()
        }
    }
    
    func logMessage(_ message: String,
                    level: LogLevel,
                    file: String = #file,
                    line: Int = #line) -> String {
        return "[\(level.title)] \(message)\n\(file):\(line)"
    }
    
    func logMessage(_ error: LocalizedError,
                    level: LogLevel,
                    file: String = #file,
                    line: Int = #line) -> String {
        
        var message = "[\(level.title)] \(error.localizedDescription)\n\(file):\(line)"
        
        if let reason = error.failureReason {
            message += "\nReason: \(reason)"
        }
        if let suggestion = error.recoverySuggestion {
            message += "\nSuggestion: \(suggestion)"
        }
        return message
    }
}
