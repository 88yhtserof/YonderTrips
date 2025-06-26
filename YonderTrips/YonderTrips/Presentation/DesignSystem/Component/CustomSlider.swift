//
//  CustomSlider.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/23/25.
//

import SwiftUI

struct CustomSlider: View {
    
    @Binding private var sliderValue: Double
    @State private var dragOffset: Double = 0.0
    
    init(sliderValue: Binding<Double>) {
        self._sliderValue = sliderValue
    }
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Custom track
                    Rectangle()
                        .foregroundColor(.gray15)
                        .frame(height: 12)
                    
                    // Filled portion
                    Rectangle()
                        .foregroundStyle(
                            LinearGradient(colors: [.lightSeafoam, .deepSeafoam, .lightSeafoam, .deepSeafoam], startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(
                            width: widthOfSlider(width: geometry.size.width),
                            height: 12
                        )
                        .offset(x: -geometry.size.width / 2 + ((geometry.size.width * CGFloat((sliderValue + (dragOffset / geometry.size.width * 100)) / 100)) / 2))
                }
                .frame(height: 12)
                .cornerRadius(10)
                .padding(12)
                .overlay {
                    indicatorView(width: geometry.size.width)
                }
            }
        }
        .background(.gray0)
        .frame(height: 12 * 3)
        .cornerRadius(6)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(LinearGradient(colors: [.lightSeafoam, .deepSeafoam, .lightSeafoam, .deepSeafoam], startPoint: .leading, endPoint: .trailing), lineWidth: 1)
        }
        .padding(.horizontal, 16)
    }
}

//MARK: - View
extension CustomSlider {
    
    func indicatorView(width: Double) -> some View {
        
        Image(systemName: "map.fill")
            .resizable()
            .frame(width: 25, height: 20)
            .foregroundStyle(.gray0)
            .shadow(radius: 4)
            .offset(x: offsetOfIndicator(width: width))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        
                        sliderValue += dragOffset / width * 100
                        dragOffset = 0
                    }
            )
    }
}

//MARK: - Feature
extension CustomSlider {
    
    func widthOfSlider(width: Double) -> Double {
        let result = width * CGFloat((sliderValue + (dragOffset / width * 100)) / 100)
        let maxWidth = width - 12 * 2
        
        if result >= maxWidth {
            return maxWidth
        } else if result <= 0 {
            return 0
        } else {
            return result
        }
    }
    
    func offsetOfIndicator(width: Double) -> Double {
        let result = -width / 2 + (width * CGFloat((sliderValue + (dragOffset / width * 100)) / 100))
        let maxWidth = width - 16 * 2
        
        if result >= (maxWidth / 2) {
            return (maxWidth / 2)
        } else if result <= -(maxWidth / 2) {
            return -(maxWidth / 2)
        } else {
            return result
        }
    }
}

#Preview {
    CustomSlider(sliderValue: Binding(get: { 100.0 }, set: { _ in }))
}
