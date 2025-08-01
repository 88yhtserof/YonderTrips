//
//  ActivityDetailViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import Foundation

final class ActivityDetailViewModel: ViewModelType {
    
    @Published var state: State
    
    let activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
        self.state = State(activity: activity)
        print(activity)
        binding()
    }
    
    struct State {
        var activity: Activity
        var selectedItemName: String?
        var selectedItemTime: String?
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension ActivityDetailViewModel {
    
    enum Action {
        
    }
    
    @MainActor
    func action(_ action: Action) {
        
    }
}

