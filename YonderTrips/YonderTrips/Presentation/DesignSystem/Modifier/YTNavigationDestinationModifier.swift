//
//  YTNavigationDestinationModifier.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/8/25.
//

import SwiftUI

struct YTNavigationDestinationModifier<D, C>: ViewModifier where D: Hashable, C: View {
    
    let data: D.Type
    @ViewBuilder let destination: (D) -> C
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: data) { flow in
                YTDestinationWrapper {
                    destination(flow)
                }
            }
    }
}

extension View {
    
    func ytNavigationDestination<D, C>(
        for data: D.Type,
        @ViewBuilder content: @escaping (D) -> C
    ) -> some View where D: Hashable, C: View {
        
        modifier(YTNavigationDestinationModifier(data: data, destination: content))
    }
}
