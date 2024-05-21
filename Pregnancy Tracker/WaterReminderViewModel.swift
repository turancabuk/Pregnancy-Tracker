//
//  WaterReminderViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 15.05.2024.
//

import UIKit

class WaterReminderViewModel {
    
    private(set) var selectedH: Int = 0
    private(set) var selectedM: Int = 0
    
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                return
            case .authorized:
                DispatchQueue.main.async {
                    self.dispatchNotification()
                }
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        DispatchQueue.main.async {
                            self.dispatchNotification()
                        }
                    }
                }
            default:
                return
            }
        }
    }
    func dispatchNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let identifier = "water-reminder"
        
        // Mevcut tüm bildirim isteklerini kaldır
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        let content = UNMutableNotificationContent()
        content.title = "Time to drink something"
        content.body = "Let's have something to drink"
        content.sound = .default

        let interval = TimeInterval((selectedH * 3600) + (selectedM * 60))
        let calendar = Calendar.current
        var nextTriggerDate = Date()

        // Gece saatleri için doğru başlangıç zamanını hesapla
        while true {
            let currentHour = calendar.component(.hour, from: nextTriggerDate)
            if currentHour >= 22 || currentHour < 9 {
                // Gece saatleri arasında bir sonraki gün 09:00'a atla
                nextTriggerDate = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: nextTriggerDate.addingTimeInterval(24 * 60 * 60))!
            } else {
                break
            }
        }

        // 24 saat boyunca geçerli bildirimleri ayarla
        while nextTriggerDate.timeIntervalSinceNow < 24 * 60 * 60 {
            let triggerHour = calendar.component(.hour, from: nextTriggerDate)
            if triggerHour >= 22 || triggerHour < 9 {
                // Eğer gece saatlerine denk gelirse bir sonraki güne atla
                nextTriggerDate = calendar.date(bySettingHour: 9, minute: 0, second: 0, of: nextTriggerDate.addingTimeInterval(24 * 60 * 60))!
                continue
            }

            let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nextTriggerDate), repeats: false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            notificationCenter.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
            nextTriggerDate = nextTriggerDate.addingTimeInterval(interval)
        }
    }

    func updateTime(hour: Int, minute: Int) {
        self.selectedH = hour
        self.selectedM = minute
    }
}
