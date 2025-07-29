//
//  AppDelegate.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/14/25.
//

import UIKit
import UserNotifications

import FirebaseCore
import FirebaseMessaging
import iamport_ios

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    private var fcmTokenUseCase: FCMTokenUseCase?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let messageTokenRepository = MessageTokenRepository()
        self.fcmTokenUseCase = FCMTokenUseCase(repository: messageTokenRepository)
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            YonderTripsLogger.shared.debug("Notification permission granted: \(granted)")
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        return true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Iamport.shared.receivedURL(url)
        return true
    }
}

//MARK: - User Notification
extension AppDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        
        if let roomId = userInfo["room_id"] as? String {
            removeNotification(for: roomId)
            NotificationNavigationManager.shared.navigateToChatRoomList()
        }
    }
    
    func removeNotification(for roomId: String) {
        let center = UNUserNotificationCenter.current()
        
        center.getDeliveredNotifications { notifications in
            let identifiersToRemove = notifications
                .filter{ $0.request.content.userInfo["room_id"] as? String == roomId }
                .map{ $0.request.identifier }
            
            center.removeDeliveredNotifications(withIdentifiers: identifiersToRemove)
        }
    }
}

//MARK: - Firebase Messaging
extension AppDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let fcmToken {
            YonderTripsLogger.shared.debug("FCM Token: \(fcmToken)")
            fcmTokenUseCase?.save(token: fcmToken)
        } else {
            YonderTripsLogger.shared.debug("Failed to get FCM Token.")
        }
    }
}
