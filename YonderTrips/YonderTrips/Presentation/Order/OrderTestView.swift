//
//  OrderTestView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import SwiftUI
import WebKit

struct OrderTestView: View {
    
    @StateObject var viewMdoel: OrderTestViewModel
    
    var body: some View {
        
        VStack {
            Button {
                print("주문 생성")
                viewMdoel.action(.requestOrderCreate)
            } label: {
                Text("예약하기")
            }
        }
        .fullScreenCover(isPresented: $viewMdoel.state.isPresentedPaymentRequest) {
            
            if let orderCreate = viewMdoel.state.orderCreate {
                PaymentRequestView(orderCreate: orderCreate)
            }
        }
    }
}
