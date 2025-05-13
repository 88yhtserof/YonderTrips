//
//  Logging.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/13/25.
//

import Foundation
import os.log

protocol Logging {
    
    func log(_ message: String, type: OSLogType, file: String, line: Int)
    func error(_ error: LocalizedError, file: String, line: Int)
}
