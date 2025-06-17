//
//  PaymentUseCase.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/17/25.
//

import Foundation

struct PaymentUseCase {
    
    func requestPayment(with impUid: String) async throws -> ReceiptOrder {
        
        let request = PaymentValidationRequestDTO(impUid: impUid)
        
        let response: ReceiptOrderResponseDTO = try await NetworkService.requestWithAuth(apiProvider: .payment(.validation(request)))
        return response.toEntity()
    }
}
