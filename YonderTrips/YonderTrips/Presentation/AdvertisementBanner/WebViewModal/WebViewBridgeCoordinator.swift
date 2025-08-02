//
//  WebViewBridgeCoordinator.swift
//  YonderTrips
//
//  Created by 임윤휘 on 7/30/25.
//

import SwiftUI
import WebKit

final class WebViewBridgeCoordinator: NSObject, ObservableObject {
    weak var webView: WKWebView?
    @Published var isLoading = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func setupWebView() -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()
        
        controller.add(self, name: "click_attendance_button")
        controller.add(self, name: "complete_attendance")
        
        configuration.userContentController = controller
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        self.webView = webView
        
        return webView
    }
    
    func loadURL(_ endPoint: String) {
        let baseURL = YTAPIProvider.baseURL
        let urlString = "\(baseURL)\(endPoint)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        let key = YTAPIProvider.apiKey
        
        request.setValue(key, forHTTPHeaderField: "SeSACKey")
        
        webView?.load(request)
    }
    
    deinit {
        webView?.configuration.userContentController.removeScriptMessageHandler(forName: "click_attendance_button")
        webView?.configuration.userContentController.removeScriptMessageHandler(forName: "complete_attendance")
    }
}

// MARK: - WKScriptMessageHandler
extension WebViewBridgeCoordinator: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "click_attendance_button":
            let accessToken = AuthTokenProvider.access.token ?? ""
            webView?.evaluateJavaScript("requestAttendance('\(accessToken)')") { result, error in
                if let error = error {
                    YonderTripsLogger.shared.debug("Failed to request attendance: \(error.localizedDescription)")
                }
            }
            
        case "complete_attendance":
            if let attendanceCount = message.body as? Int {
                alertMessage = "\(attendanceCount)번째 출석이 완료되었습니다!"
                showAlert = true
            }
            
        default:
            break
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebViewBridgeCoordinator: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isLoading = false
        YonderTripsLogger.shared.debug("Failed to load web view: \(error.localizedDescription)")
    }
}
