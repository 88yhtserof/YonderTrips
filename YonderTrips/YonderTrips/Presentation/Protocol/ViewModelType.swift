//
//  ViewModelType.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/21/25.
//

import SwiftUI

protocol ViewModelType: ObservableObject {
    
    associatedtype State
    associatedtype Action
    
    var state: State { get }
    
    func binding()
    @MainActor func action(_ action: Action)
}
