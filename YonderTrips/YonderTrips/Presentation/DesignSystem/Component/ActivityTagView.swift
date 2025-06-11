//
//  ActivityTagView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct ActivityTagView: View {
    
    let tag: String
    
    var body: some View {
        
        HStack {
            Image(.twinkle)
                .resizable()
                .frame(width: 13, height: 13)
            
            Text(tag)
                .font(.yt(.pretendard(.caption1)))
        }
        .frame(width: 150, height: 20)
        .foregroundColor(.gray0)
        .padding(.vertical, 3)
        .padding(.horizontal, 10)
        .background(.gray0.opacity(0.6))
        .cornerRadius(8)
        .shadow(color: .gray100, radius: 8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray0, lineWidth: 1)
        }
    }
}

#Preview {
    ActivityTagView(tag: "New 오픈 특가")
}
