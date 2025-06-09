//
//  HomeFlowRouter.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

final class HomeFlowRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    enum HomeFlow: Hashable {
        case newActivityList
        case newActivityDetail
        case activityPostList
        case activityPostDetail
        case category
        case activityFilter(ActivityCategory, ActivityCountry)
    }
}
