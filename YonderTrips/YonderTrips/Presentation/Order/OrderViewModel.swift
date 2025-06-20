//
//  OrderViewModel.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

final class OrderViewModel: ViewModelType {
    
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
extension OrderViewModel {
    
    enum Action {
        case requestOrderCreate(id: String, name: String, time: String, participantCount: Int, totalPrice: Int)
        case didPaymentRequestFinish(Result<ReceiptOrder, YonderTripsNetworkError>)
    }
    
    @MainActor
    func action(_ action: Action) {
        switch action {
        case let .requestOrderCreate(id, name, time, participantCount, totalPrice):
            let orderRequest = OrderRequest(
                activityId: id,
                reservationItemName: name,
                reservationItemTime: time,
                participantCount: participantCount,
                totalPrice: totalPrice
            )
            
            Task {
                do {
                    let order = try await orderUseCase.requestOrderCreate(with: orderRequest)
                    state.orderCreate = OrderCreate(
                        orderId: order.orderId,
                        orderCode: order.orderCode,
                        totalPrice: order.totalPrice,
                        createdAt: YTDateFormatter.string(from: Date(), format: .iso8601),
                        updatedAt: YTDateFormatter.string(from: Date(), format: .iso8601)
                    )
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
