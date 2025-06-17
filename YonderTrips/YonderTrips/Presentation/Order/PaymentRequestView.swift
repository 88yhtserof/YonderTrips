//
//  PaymentRequestView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import SwiftUI

import iamport_ios

struct PaymentRequestContentView: UIViewControllerRepresentable {
    
    let orderCreate: OrderCreate
    let onDismiss: (IamportResponse) -> Void
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return PaymentRequestViewController(orderCreate: orderCreate, onDismiss: onDismiss)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct PaymentRequestView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let paymentUseCase = PaymentUseCase()
    
    let orderCreate: OrderCreate
    let onDismiss: (Result<ReceiptOrder, YonderTripsNetworkError>) -> Void
    
    var body: some View {
        
        VStack {
            PaymentRequestContentView(orderCreate: orderCreate, onDismiss: handleOnDismiss)
        }
    }
    
    func handleOnDismiss(_ paymentResponse: IamportResponse) {
        
        if let imp_uid = paymentResponse.imp_uid {
            Task {
                do {
                    let receiptResponse = try await paymentUseCase.requestPayment(with: imp_uid)
                    onDismiss(.success(receiptResponse))
                    
                } catch let error as YonderTripsNetworkError {
                    onDismiss(.failure(error))
                }
            }
        }
        dismiss()
    }
}
