//
//  AdvertisementBannerCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/11/25.
//

import SwiftUI

struct AdvertisementBannerCellView: View {
    
    let item: String
    
    var body: some View {
        
        VStack {
            DataImageView(urlString: item)
        }
    }
}

#Preview {
    AdvertisementBannerCellView(item: "")
}

