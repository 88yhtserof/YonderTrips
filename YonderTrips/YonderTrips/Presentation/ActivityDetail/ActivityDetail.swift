//
//  ActivityDetail.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct ActivityDetail: View {
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(.tripsPoster)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.gray0, location: 0.15),
                        .init(color: Color.clear, location: 0.65)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ActivityDetail()
}
