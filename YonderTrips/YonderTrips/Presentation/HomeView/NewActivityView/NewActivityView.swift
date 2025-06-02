//
//  NewActivityView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import SwiftUI

/// A SwiftUI wrapper that bridges a NewActivityViewController (UIKit) into a SwiftUI view using the UIViewControllerRepresentable protocol.
struct NewActivityContentView: UIViewControllerRepresentable {
    
    let activityList: [Activity]
    
    func makeUIViewController(context: Context) -> NewActivityViewController {
        return NewActivityViewController(list: activityList)
    }
    
    func updateUIViewController(_ uiViewController: NewActivityViewController, context: Context) {
        uiViewController.updateList(with: activityList)
    }
}

struct NewActivityView: View {
    @StateObject var viewModel: NewActivityViewModel
    
    var body: some View {
        NewActivityContentView(activityList: viewModel.state.activityList)
            .environmentObject(viewModel)
            .onAppear {
                viewModel.action(.onAppear)
            }
    }
}
