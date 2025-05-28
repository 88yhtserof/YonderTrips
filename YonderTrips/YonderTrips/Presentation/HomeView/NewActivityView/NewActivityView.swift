//
//  NewActivityView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/24/25.
//

import SwiftUI

struct NewActivityView: UIViewControllerRepresentable {
    let list: [String]
    
    func makeUIViewController(context: Context) -> NewActivityViewController {
        return NewActivityViewController(list: list)
        }
        
        func updateUIViewController(_ uiViewController: NewActivityViewController, context: Context) {
            
        }
}
