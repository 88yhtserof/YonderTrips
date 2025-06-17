//
//  PaymentRequestViewController.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/16/25.
//

import UIKit

import iamport_ios
import WebKit

final class PaymentRequestViewController: UIViewController {
    
    // properties
    let orderCreate: OrderCreate
    
    // views
    lazy var wkWebView: WKWebView = {
        var view = WKWebView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // life cycle
    init(orderCreate: OrderCreate) {
        self.orderCreate = orderCreate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestIamportPayment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        wkWebView.stopLoading()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Iamport.shared.close()
//        presentationMode?.wrappedValue.dismiss()
    }
    
    // feature
    func requestIamportPayment() {
        let userCode = "imp14511373"
        let payment = createPaymentData()
        
        
        Iamport.shared.paymentWebView(
            webViewMode: wkWebView,
            userCode: userCode,
            payment: payment
        ) { [weak self] response in
            
            print("결과 : \(response)")
            
            guard let response else {
                YonderTripsLogger.shared.debug("Could not find response")
                return
            }
            
            
        }
    }
    
    func createPaymentData() -> IamportPayment {
        return IamportPayment(
            pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
            merchant_uid: orderCreate.orderCode,
            amount: "\(orderCreate.totalPrice)")
        .then {
            $0.pay_method = PayMethod.card.rawValue
            $0.name = "YonderTrips 예약 상품"
            $0.buyer_name = "임윤휘"
            $0.app_scheme = AuthorizationProvider.iamport.scheme
        }
    }
}

//MARK: - Configuration
private extension PaymentRequestViewController {
    
    func configureView() {
        
        wkWebView.frame = view.frame
    }
    
    func configureHierarchy() {
        
        view.addSubview(wkWebView)
    }
    
    func configureConstraints() {

        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        wkWebView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        wkWebView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        wkWebView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wkWebView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
