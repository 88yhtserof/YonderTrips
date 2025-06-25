//
//  ActivityFilterView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/6/25.
//

import SwiftUI

struct ActivityFilterView: View {
    
    @EnvironmentObject private var homeRouter: HomeFlowRouter
    @State var selectedCategory: ActivityCategory
    @State var selectedCountry: ActivityCountry
    let flow: HomeFlowRouter.HomeFlow
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                VerticalShadowDivider()
                
                VStack(spacing: -12) {
                    HeaderView<EmptyView>(title: "카테고리")
                    
                    CategoryFilterListView(selectedCategory: $selectedCategory)
                }
                
                VerticalDivider()
                    .padding(.top, 8)
                
                VStack(spacing: -12) {
                    HeaderView<EmptyView>(title: "국가")
                    
                    CountryFilterListView(selectedCountry: $selectedCountry)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: handleDoneButton) {
                    Text("완료")
                }
                .buttonStyle(DisabledButtonStyle())
            }
            
            ToolbarItem(placement: .principal) {
                Text("액티비티 필터")
                    .font(.yt(.paperlogy(.caption1)))
                    .foregroundStyle(.deepSeafoam)
            }
        }
    }
}

//MARK: - Action
extension ActivityFilterView {
    
    func handleDoneButton() {
        
        switch flow {
        case .activityList:
            homeRouter.path.append(HomeFlowRouter.HomeFlow.activityList(selectedCategory, selectedCountry))
        case .activityPostList:
            homeRouter.path.append(HomeFlowRouter.HomeFlow.activityPostList(selectedCategory, selectedCountry))
        default:
            break
        }
    }
}
