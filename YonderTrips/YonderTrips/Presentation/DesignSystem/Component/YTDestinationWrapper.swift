//
//  YTDestinationWrapper.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/8/25.
//

import SwiftUI

struct YTDestinationWrapper<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .ytNavigationBarBackButton()
            .navigationBarTitleDisplayMode(.automatic)
    }
}
