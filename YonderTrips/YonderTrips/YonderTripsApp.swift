//
//  YonderTripsApp.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/12/25.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct YonderTripsApp: App {
    @StateObject private var rootViewRouter = RootFlowRouter()
    
    init() {
        KakaoSDK.initSDK(appKey: AuthorizationProvider.kakao.apiKey ?? "")
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(rootViewRouter)
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        let _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
