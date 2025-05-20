//
//  YTButtonStyle.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/20/25.
//

import SwiftUI

struct YTButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 100, height: 30)
            .background(.blackSeafoam)
            .clipShape(RoundedRectangle(cornerRadius: 3.6))
    }
}
