//
//  CategoryView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/22/25.
//

import SwiftUI

struct CategoryView: View {
    
    private let categories = CategoryType.allCases
    
    var body: some View {
        
        ScrollView(.horizontal) {
            HStack {
                ForEach(categories, id: \.self) { category in
                    categoryButtonStyle(category)
                }
            }
            .padding(8)
        }
        .scrollIndicators(.hidden)
    }
}

//MARK: - View
extension CategoryView {
    
    func categoryButtonStyle(_ category: CategoryType) -> some View {
        VStack {
            Image(category.image)
                .frame(width: 60, height: 60)
                .background(.gray0)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(category.title)
                .font(Font.yt(.pretendard(.body2)))
                .foregroundStyle(.gray90)
        }
    }
}

//MARK: - Type
extension CategoryView {
    
    enum CategoryType: String, CaseIterable {
        case tourism
        case tour
        case package
        case exciting
        case experience
        case random
        
        var title: String {
            switch self {
            case .tourism:
                "관광"
            case .tour:
                "투어"
            case .package:
                "패키지"
            case .exciting:
                "익사이팅"
            case .experience:
                "체험"
            case .random:
                "랜덤"
            }
        }
        
        var image: String {
            return self.rawValue
        }
    }
}

#Preview {
    CategoryView()
}
