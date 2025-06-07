//
//  YonderTripsLogger.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import SwiftUICore
import os.log

final class YonderTripsLogger {
    
    static let shared = YonderTripsLogger(category: "default")
    
    private let logger: Logger
    
    private init(subsystem: String = "com.tistory.88yhtserof.YonderTrips",
         category: String) {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
    
    func notice(_ message: String,
               file: String = #file,
               line: Int = #line) {
        
        log(message, type: .default, file: file, line: line)
    }
    
    func fault(_ message: String,
               file: String = #file,
               line: Int = #line) {
        
        log(message, type: .fault, file: file, line: line)
    }
    
    func error(_ error: LocalizedError,
               file: String = #file,
               line: Int = #line) {
        
        let level = LogLevel(rawValue: .error)
        let log = logMessage(error, level: level, file: file, line: line)
        logger.log(level: .error, "\(log)")
    }
    
    func debug(_ message: String,
               file: String = #file,
               line: Int = #line) {
#if DEBUG
        log(message, type: .debug, file: file, line: line)
#endif
    }
    
    func info(_ message: String,
               file: String = #file,
               line: Int = #line) {
#if DEBUG
        log(message, type: .info, file: file, line: line)
#endif
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
    
    func log(_ message: String,
             type: OSLogType,
             file: String,
             line: Int) {
        
        let level = LogLevel(rawValue: type)
        let log = logMessage(message, level: level, file: file, line: line)
        logger.log(level: type, "\(log)")
    }
    
    func logMessage(_ message: String,
                    level: LogLevel,
                    file: String,
                    line: Int) -> String {
        return "[\(level.title)] \(message)\n\(file):\(line) (\(Date()))"
    }
    
    func logMessage(_ error: LocalizedError,
                    level: LogLevel,
                    file: String,
                    line: Int) -> String {
        
        var message = "[\(level.title)] \(error.localizedDescription)\n\(file):\(line) (\(Date()))"
        
        if let reason = error.failureReason {
            message += "\nReason: \(reason)"
        }
        if let suggestion = error.recoverySuggestion {
            message += "\nSuggestion: \(suggestion)"
        }
        return message
    }
}
