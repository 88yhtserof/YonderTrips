//
//  HeaderView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import SwiftUI

struct HeaderView<Label>: View where Label: View {
    
    let title: String
    let action: () -> Void
    @ViewBuilder let label: () -> Label
    
    var body: some View {
        
        HStack {
            Text(title)
                .font(Font.yt(.pretendard(.body2)))
                .foregroundStyle(.gray90)
            
            Spacer()
            
            Button(action: action, label: label)
        }
        .padding(16)
    }
}
//
//#Preview {
//    HeaderView(title: "NewActivity", buttonTitle: "View All") {
//        print("did Button Tapped")
//    }
//}

