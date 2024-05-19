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
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        for minuteOffset in 1...60 {
            let content = UNMutableNotificationContent()
            content.title = "Time to drink something"
            content.body = "Let's have something to drink"
            
            var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date(timeIntervalSinceNow: Double(minuteOffset * 60)))
            let currentHour = dateComponents.hour ?? 0
            
            if currentHour >= 16 && currentHour <= 17 {
                content.sound = nil
            } else {
                content.sound = .default
            }
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "\(identifier)-\(minuteOffset)", content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }

    func updateTime(hour: Int, minute: Int) {
        self.selectedH = hour
        self.selectedM = minute
    }
}
