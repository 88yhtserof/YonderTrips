//
//  PaymentRequestView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import SwiftUI

struct PaymentRequestContentView: UIViewControllerRepresentable {
    
    let orderCreate: OrderCreate
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return PaymentRequestViewController(orderCreate: orderCreate)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct PaymentRequestView: View {
    
    let orderCreate: OrderCreate
    
    var body: some View {
        
        VStack {
            PaymentRequestContentView(orderCreate: orderCreate)
        }
    }
}
