//
//  AdvertisementTagView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/10/25.
//

import SwiftUI

struct AdvertisementTagView: View {
    
    let isAdvertisement: Bool
    
    var body: some View {
        
        if !isAdvertisement {
            EmptyView()
            
        } else {
            HStack {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 12, height: 12)
                
                Text("광고")
                    .font(.yt(.pretendard(.caption3)))
            }
            .foregroundColor(.gray0)
            .padding(.vertical, 3)
            .padding(.horizontal, 5)
            .background(.gray0.opacity(0.45))
            .cornerRadius(15)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray0, lineWidth: 0.6)
            }
        }
    }
}

#Preview {
    AdvertisementTagView(isAdvertisement: true)
}
