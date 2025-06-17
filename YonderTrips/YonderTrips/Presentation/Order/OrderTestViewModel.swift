//
//  OrderTestViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

final class OrderTestViewModel: ViewModelType {
    
    @Published var state = State()
    
    private let orderUseCase: OrderUseCase
    
    init(orderUseCase: OrderUseCase) {
        self.orderUseCase = orderUseCase
    }
    
    struct State {
        var isPresentedPaymentRequest: Bool = false
        var orderCreate: OrderCreate? = nil
        
        var isPresentedPopup: Bool = false
        var successMessage: String? = nil
        var errorMessage: String? = nil
    }
    
    func binding() {
        
    }
}

//MARK: - Action
extension OrderTestViewModel {
    
    enum Action {
        case requestOrderCreate
        case didPaymentRequestFinish(Result<ReceiptOrder, YonderTripsNetworkError>)
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case .requestOrderCreate:
            let orderRequest: OrderRequest = .init(activityId: "-", reservationItemName: "2025-06-18", reservationItemTime: "10:00", participantCount: 1, totalPrice: 116)
            
            Task {
                do {
                    let order = try await orderUseCase.requestOrderCreate(with: orderRequest)
                    state.orderCreate = OrderCreate(orderId: order.orderId, orderCode: order.orderCode, totalPrice: order.totalPrice, createdAt: "2025-08-01T15:30:00.000Z", updatedAt: "2025-08-01T15:30:00.000Z")
                    state.isPresentedPaymentRequest = true
                    
                } catch {
                    state.errorMessage = error.localizedDescription
                    state.isPresentedPopup = true
                }
            }
            
        case .didPaymentRequestFinish(let result):
            switch result {
            case .success:
                state.errorMessage = nil
                state.successMessage = "결제가 완료되었습니다."
                state.isPresentedPopup = true
                
            case .failure(let error):
                state.successMessage = nil
                state.errorMessage = error.localizedDescription
                state.isPresentedPopup = true
            }
        }
    }
}
