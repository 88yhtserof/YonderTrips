//
//  WebViewBridgeView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/30/25.
//

import SwiftUI
import WebKit

struct WebViewBridgeView: UIViewRepresentable {
    let url: String
    @StateObject private var coordinator: WebViewBridgeCoordinator
    
    init(url: String) {
        self.url = url
        self._coordinator = StateObject(wrappedValue: WebViewBridgeCoordinator())
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = coordinator.setupWebView()
        coordinator.loadURL(url)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
