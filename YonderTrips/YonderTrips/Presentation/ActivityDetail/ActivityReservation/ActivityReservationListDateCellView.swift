//
//  ActivityReservationListDateCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import SwiftUI

struct ActivityReservationListDateCellView: View {
    let date: Date
    let isDisabled: Bool
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: handleSelection) {
            
            Text("\(date.dayOfMonth)월 \(date.day)일")
        }
        .buttonStyle(ThreeStateButtonStyle(isSelected: isSelected, isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

//MARK: - Action
extension ActivityReservationListDateCellView {
    
    func handleSelection() {
        isSelected = true
    }
}

struct ActivityReservationListCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ActivityReservationListDateCellView(date: Date(), isDisabled: true, isSelected: Binding(get: {false}, set: {_ in}))
            ActivityReservationListDateCellView(date: Date(), isDisabled: false, isSelected: Binding(get: {true}, set: {_ in}))
            ActivityReservationListDateCellView(date: Date(), isDisabled: false, isSelected: Binding(get: {false}, set: {_ in}))
        }
    }
}
