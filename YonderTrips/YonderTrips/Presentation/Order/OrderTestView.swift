//
//  OrderTestView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import SwiftUI
import WebKit

struct OrderTestView: View {
    
    @StateObject var viewMdoel: OrderViewModel
    
    var body: some View {
        
        VStack {
            Button {
                viewMdoel.action(.requestOrderCreate)
            } label: {
                Text("예약하기")
            }
        }
        .overlay {
            if viewMdoel.state.isPresentedPopup {
                
                if let errorMessage = viewMdoel.state.errorMessage {
                    PopupView(
                        title: errorMessage,
                        isPresented: $viewMdoel.state.isPresentedPopup
                    )
                } else if let successMessage = viewMdoel.state.successMessage {
                    PopupView(
                        title: successMessage,
                        isPresented: $viewMdoel.state.isPresentedPopup
                    )
                }
            }
        }
        .fullScreenCover(isPresented: $viewMdoel.state.isPresentedPaymentRequest) {
            
            if let orderCreate = viewMdoel.state.orderCreate {
                PaymentRequestView(orderCreate: orderCreate) { result in
                    viewMdoel.action(.didPaymentRequestFinish(result))
                }
            }
        }
    }
}
