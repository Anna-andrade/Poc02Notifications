//
//  NotificationManager.swift
//  Poc02Notifications
//
//  Created by Anna Carolina Costa Andrade on 01/09/22.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject{
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus(){
        UNUserNotificationCenter.current().getNotificationSettings {settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
            
        }
    }
    
    func reloadLocalNotifications() {
        print("reload local notifications")
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
            
        }
    }
}


