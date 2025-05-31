//
//  NewActivityView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import SwiftUI

/// A SwiftUI wrapper that bridges a NewActivityViewController (UIKit) into a SwiftUI view using the UIViewControllerRepresentable protocol.
struct NewActivityContentView: UIViewControllerRepresentable {
    
    let viewModel: NewActivityViewModel
    
    func makeUIViewController(context: Context) -> NewActivityViewController {
        return NewActivityViewController(list: viewModel.state.list)
    }
    
    func updateUIViewController(_ uiViewController: NewActivityViewController, context: Context) {
        
    }
}

struct NewActivityView: View {
    @StateObject private var viewModel = NewActivityViewModel()
    
    var body: some View {
        NewActivityContentView(viewModel: viewModel)
            .environmentObject(viewModel)
            .onAppear {
                viewModel.action(.onAppear)
            }
    }
}
