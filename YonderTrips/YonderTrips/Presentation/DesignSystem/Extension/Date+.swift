//
//  Date+.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import Foundation

extension Date {
    var dayOfMonth: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
}
