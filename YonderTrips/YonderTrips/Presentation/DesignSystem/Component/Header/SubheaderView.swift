//
//  SubheaderView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct SubheaderView: View {
    
    let title: String
    
    var body: some View {
        
        HStack {
            Text(title)
                .font(Font.yt(.pretendard(.body2)).weight(.bold))
                .foregroundStyle(.gray45)
            
            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    SubheaderView(title: "액티비티 커리큘럼")
}
