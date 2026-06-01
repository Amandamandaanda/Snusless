//
//  Notifications+Extension.swift
//  Snusless
//
//  Created by Amanda Tana on 2026-06-01.
//
import UserNotifications

extension SettingsView {
    
    func sendNotification(date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Snusless"
        content.subtitle = "Glöm inte att checka in idag!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: true)
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyCheckInReminder"])
        
        let request = UNNotificationRequest(identifier: "dailyCheckInReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        
    }
}
