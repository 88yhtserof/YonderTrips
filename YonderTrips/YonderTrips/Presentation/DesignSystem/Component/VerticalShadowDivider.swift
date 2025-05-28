//
//  VerticalShadowDivider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/28/25.
//

import SwiftUI

struct VerticalShadowDivider: View {
    var body: some View {
        
        VStack {
            Color.lightSeafoam
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .padding(.top, 8)
        }
    }
}

#Preview {
    VerticalShadowDivider()
}
