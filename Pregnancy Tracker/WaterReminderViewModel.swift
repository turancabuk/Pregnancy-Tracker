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
        let identifier = "water-reminder"
        let title = "Time to drink something"
        let body = "Let's have something to drink"

        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let totalSeconds = (selectedH * 3600) + (selectedM * 60)
        guard totalSeconds >= 60 else { return }

        let startSilenceHour = 22
        let endSilenceHour = 9

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totalSeconds), repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                let calendar = Calendar.current
                let now = Date()
                let silenceStart = calendar.date(bySettingHour: startSilenceHour, minute: 0, second: 0, of: now)!
                let silenceEnd = calendar.date(bySettingHour: endSilenceHour, minute: 0, second: 0, of: now)!

                if now >= silenceStart && now <= silenceEnd {
                    notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
                } else {
                    notificationCenter.add(request)
                }
            }
        }
    }
    func updateTime(hour: Int, minute: Int) {
        self.selectedH = hour
        self.selectedM = minute
    }
}
