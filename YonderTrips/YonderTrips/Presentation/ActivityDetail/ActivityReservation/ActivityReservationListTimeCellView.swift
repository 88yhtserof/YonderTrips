//
//  ActivityReservationListTimeCellView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/19/25.
//

import SwiftUI

struct ActivityReservationListTimeCellView: View {
    let time: String
    let isDisabled: Bool
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: handleSelection) {
            
            Text(time)
        }
        .buttonStyle(ThreeStateButtonStyle(isSelected: isSelected, isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

//MARK: - Action
extension ActivityReservationListTimeCellView {
    
    func handleSelection() {
        print(#function)
        isSelected = true
    }
}

struct ActivityReservationListTimeCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ActivityReservationListTimeCellView(time: "10:00", isDisabled: true, isSelected: Binding(get: {false}, set: {_ in}))
            ActivityReservationListTimeCellView(time: "10:00", isDisabled: false, isSelected: Binding(get: {true}, set: {_ in}))
            ActivityReservationListTimeCellView(time: "10:00", isDisabled: false, isSelected: Binding(get: {false}, set: {_ in}))
        }
    }
}
