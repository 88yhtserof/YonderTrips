//
//  YonderTripsApp.swift
//  YonderTrips
//
//  Created by 임윤휘 on 5/12/25.
//

import SwiftUI

@main
struct YonderTripsApp: App {
    @StateObject private var rootViewRouter = RootFlowRouter()
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(rootViewRouter)
        }
    }
}
