//
//  SignInView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/19/25.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("YonderTrips.")
                .lineSpacing(8)
                .font(Font.yt(.paperlogy(.caption2)))
                .foregroundColor(.gray15)
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
                .background(.blackSeafoam)
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .padding(.top, 55)
                .padding(.leading, 16)
            
            Text("Your Trips,\nYonder Bound")
                .lineSpacing(6)
                .font(Font.yt(.paperlogy(.slogan1)))
                .foregroundColor(.gray0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
                .padding(.leading, 16)
            
            Text("저 너머 당신의 멋진 여행을 위해")
                .font(Font.yt(.paperlogy(.slogan2)))
                .foregroundColor(.gray30)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 1)
                .padding(.leading, 16)
            
            Spacer()
            
        }
        .background {
            ZStack {
                Image("TripsPoster")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                Color.gray90.opacity(0.38)
                    .ignoresSafeArea()
                
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    SignInView()
}
