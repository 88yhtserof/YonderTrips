//
//  ActivityReservationListView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import SwiftUI

struct ActivityReservationListView: View {
    
    let reservations: [ActivityReservationItem]
    @State var selectedItemName: String?
    @State var selectedItemTime: String?
    
    private var selectedReservation: ActivityReservationItem? {
        reservations.first{ $0.itemName == selectedItemName }
    }
    
    private let colums: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            SubheaderView(title: "액티비티 예약 설정")
            
            VStack(spacing: 16) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(reservations, id: \.itemName) { item in
                            ActivityReservationListDateCellView(
                                date: item.itemDate ?? Date(),
                                isDisabled: item.isFullyReserved,
                                isSelected: Binding(
                                    get: { selectedItemName == item.itemName },
                                    set: { _ in selectedItemName = item.itemName }
                                )
                            )
                        }
                    }
                    .padding(.leading, 16)
                }
                .scrollIndicators(.hidden)
                
                if let times = selectedReservation?.times {
                    
                    LazyVGrid(columns: colums) {
                        ForEach(times, id: \.self) { item in
                            ActivityReservationListTimeCellView(
                                time: item.time,
                                isDisabled: item.isReserved,
                                isSelected: Binding(
                                    get: { selectedItemTime == item.time },
                                    set: {_ in selectedItemTime = item.time}
                                )
                            )
                        }
                    }
                    .padding(16)
                    .background(.gray0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray30, lineWidth: 1)
                    )
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                }
            }
            .animation(.easeInOut(duration: 0.4), value: selectedReservation)
        }
    }
}

#Preview {
    
    ActivityReservationListView(reservations: ActivityReservationItem.dummyData)
}
