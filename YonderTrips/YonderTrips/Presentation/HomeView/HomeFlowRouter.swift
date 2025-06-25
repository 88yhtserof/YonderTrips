//
//  HomeFlowRouter.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

final class HomeFlowRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    indirect enum HomeFlow: Hashable {
        case activityList(ActivityCategory, ActivityCountry)
        case activityDetail(Activity)
        case activityPostList(ActivityCategory, ActivityCountry)
        case activityPostDetail
        case activityFilter(ActivityCategory, ActivityCountry, HomeFlowRouter.HomeFlow)
    }
}
