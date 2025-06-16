//
//  PaymentResponseDTO.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import Foundation

struct PaymentResponseDTO: Decodable {
    let impUid: String
    let merchantUid: String
    let payMethod: String?
    let channel: String?
    let pgProvider: String?
    let embPgProvider: String?
    let pgTid: String?
    let pgId: String?
    let escrow: Bool?
    let applyNum: String?
    let bankCode: String?
    let bankName: String?
    let cardCode: String?
    let cardName: String?
    let cardIssuerCode: String?
    let cardIssuerName: String?
    let cardPublisherCode: String?
    let cardPublisherName: String?
    let cardQuota: Int?
    let cardNumber: String?
    let cardType: Int?
    let vbankCode: String?
    let vbankName: String?
    let vbankNum: String?
    let vbankHolder: String?
    let vbankDate: Int?
    let vbankIssuedAt: Int?
    let name: String?
    let amount: Int
    let currency: String
    let buyerName: String?
    let buyerEmail: String?
    let buyerTel: String?
    let buyerAddr: String?
    let buyerPostcode: String?
    let customData: String?
    let userAgent: String?
    let status: String
    let startedAt: Date?
    let paidAt: Date?
    let receiptUrl: String?
    let createdAt: Date?
    let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case impUid = "imp_uid"
        case merchantUid = "merchant_uid"
        case payMethod = "pay_method"
        case channel
        case pgProvider = "pg_provider"
        case embPgProvider = "emb_pg_provider"
        case pgTid = "pg_tid"
        case pgId = "pg_id"
        case escrow
        case applyNum = "apply_num"
        case bankCode = "bank_code"
        case bankName = "bank_name"
        case cardCode = "card_code"
        case cardName = "card_name"
        case cardIssuerCode = "card_issuer_code"
        case cardIssuerName = "card_issuer_name"
        case cardPublisherCode = "card_publisher_code"
        case cardPublisherName = "card_publisher_name"
        case cardQuota = "card_quota"
        case cardNumber = "card_number"
        case cardType = "card_type"
        case vbankCode = "vbank_code"
        case vbankName = "vbank_name"
        case vbankNum = "vbank_num"
        case vbankHolder = "vbank_holder"
        case vbankDate = "vbank_date"
        case vbankIssuedAt = "vbank_issued_at"
        case name
        case amount
        case currency
        case buyerName = "buyer_name"
        case buyerEmail = "buyer_email"
        case buyerTel = "buyer_tel"
        case buyerAddr = "buyer_addr"
        case buyerPostcode = "buyer_postcode"
        case customData = "custom_data"
        case userAgent = "user_agent"
        case status
        case startedAt
        case paidAt
        case receiptUrl = "receipt_url"
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        impUid = try container.decode(String.self, forKey: .impUid)
        merchantUid = try container.decode(String.self, forKey: .merchantUid)
        payMethod = try container.decodeIfPresent(String.self, forKey: .payMethod)
        channel = try container.decodeIfPresent(String.self, forKey: .channel)
        pgProvider = try container.decodeIfPresent(String.self, forKey: .pgProvider)
        embPgProvider = try container.decodeIfPresent(String.self, forKey: .embPgProvider)
        pgTid = try container.decodeIfPresent(String.self, forKey: .pgTid)
        pgId = try container.decodeIfPresent(String.self, forKey: .pgId)
        escrow = try container.decodeIfPresent(Bool.self, forKey: .escrow)
        applyNum = try container.decodeIfPresent(String.self, forKey: .applyNum)
        bankCode = try container.decodeIfPresent(String.self, forKey: .bankCode)
        bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
        cardCode = try container.decodeIfPresent(String.self, forKey: .cardCode)
        cardName = try container.decodeIfPresent(String.self, forKey: .cardName)
        cardIssuerCode = try container.decodeIfPresent(String.self, forKey: .cardIssuerCode)
        cardIssuerName = try container.decodeIfPresent(String.self, forKey: .cardIssuerName)
        cardPublisherCode = try container.decodeIfPresent(String.self, forKey: .cardPublisherCode)
        cardPublisherName = try container.decodeIfPresent(String.self, forKey: .cardPublisherName)
        cardQuota = try container.decodeIfPresent(Int.self, forKey: .cardQuota)
        cardNumber = try container.decodeIfPresent(String.self, forKey: .cardNumber)
        cardType = try container.decodeIfPresent(Int.self, forKey: .cardType)
        vbankCode = try container.decodeIfPresent(String.self, forKey: .vbankCode)
        vbankName = try container.decodeIfPresent(String.self, forKey: .vbankName)
        vbankNum = try container.decodeIfPresent(String.self, forKey: .vbankNum)
        vbankHolder = try container.decodeIfPresent(String.self, forKey: .vbankHolder)
        vbankDate = try container.decodeIfPresent(Int.self, forKey: .vbankDate)
        vbankIssuedAt = try container.decodeIfPresent(Int.self, forKey: .vbankIssuedAt)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        amount = try container.decode(Int.self, forKey: .amount)
        currency = try container.decode(String.self, forKey: .currency)
        buyerName = try container.decodeIfPresent(String.self, forKey: .buyerName)
        buyerEmail = try container.decodeIfPresent(String.self, forKey: .buyerEmail)
        buyerTel = try container.decodeIfPresent(String.self, forKey: .buyerTel)
        buyerAddr = try container.decodeIfPresent(String.self, forKey: .buyerAddr)
        buyerPostcode = try container.decodeIfPresent(String.self, forKey: .buyerPostcode)
        customData = try container.decodeIfPresent(String.self, forKey: .customData)
        userAgent = try container.decodeIfPresent(String.self, forKey: .userAgent)
        status = try container.decode(String.self, forKey: .status)
        
        let dateFormatter = ISO8601DateFormatter()
        let startedAtString = try container.decodeIfPresent(String.self, forKey: .startedAt)
        let paidAtString = try container.decodeIfPresent(String.self, forKey: .paidAt)
        let createdAtString = try container.decodeIfPresent(String.self, forKey: .createdAt)
        let updatedAtString = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        
        startedAt = startedAtString.flatMap { dateFormatter.date(from: $0) }
        paidAt = paidAtString.flatMap { dateFormatter.date(from: $0) }
        createdAt = createdAtString.flatMap { dateFormatter.date(from: $0) }
        updatedAt = updatedAtString.flatMap { dateFormatter.date(from: $0) }
        
        receiptUrl = try container.decodeIfPresent(String.self, forKey: .receiptUrl)
    }
}



extension PaymentResponseDTO {
    
    func toEntity() -> Payment {
        return Payment(
            impUid: impUid,
            merchantUid: merchantUid,
            payMethod: payMethod,
            channel: channel,
            pgProvider: pgProvider,
            embPgProvider: embPgProvider,
            pgTid: pgTid,
            pgId: pgId,
            escrow: escrow,
            applyNum: applyNum,
            bankCode: bankCode,
            bankName: bankName,
            cardCode: cardCode,
            cardName: cardName,
            cardIssuerCode: cardIssuerCode,
            cardIssuerName: cardIssuerName,
            cardPublisherCode: cardPublisherCode,
            cardPublisherName: cardPublisherName,
            cardQuota: cardQuota,
            cardNumber: cardNumber,
            cardType: cardType,
            vbankCode: vbankCode,
            vbankName: vbankName,
            vbankNum: vbankNum,
            vbankHolder: vbankHolder,
            vbankDate: vbankDate,
            vbankIssuedAt: vbankIssuedAt,
            name: name,
            amount: amount,
            currency: currency,
            buyerName: buyerName,
            buyerEmail: buyerEmail,
            buyerTel: buyerTel,
            buyerAddr: buyerAddr,
            buyerPostcode: buyerPostcode,
            customData: customData,
            userAgent: userAgent,
            status: status,
            startedAt: startedAt,
            paidAt: paidAt,
            receiptUrl: receiptUrl,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
