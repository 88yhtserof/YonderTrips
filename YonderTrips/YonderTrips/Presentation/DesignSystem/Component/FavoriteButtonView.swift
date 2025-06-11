//
//  FavoriteButtonView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/26/25.
//

import SwiftUI

struct FavoriteButtonView: View {
    
    @State private var isFavorite = false
    let action: () -> Void
    
    var body: some View {
        Button(action: handleFavorite) {
            Image(isFavorite ? .likeFill : .likeEmpty)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isFavorite ? .rosyPunch : .gray30)
        }
    }
    
    func handleFavorite() {
        
        print(#function)
        action()
        isFavorite.toggle()
    }
}
