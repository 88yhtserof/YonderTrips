//
//  VerticalDivider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

struct VerticalDivider: View {
    var body: some View {
        
        VStack {
            Divider()
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
        }
    }
}

#Preview {
    VerticalDivider()
}
