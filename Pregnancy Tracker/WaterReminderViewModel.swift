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
        
        let startSilenceHour = 9
        let endSilenceHour = 19
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        let calendar = Calendar.current
        let now = Date()
        
        var nextTriggerDate = now
        
        // Eğer şu an sessiz saatler arasında değilse, bildirimleri düzenli aralıklarla gönder
        if !isWithinSilenceHours(date: now, startHour: startSilenceHour, endHour: endSilenceHour) {
            // Bildirimlerin belirli bir sıklıkta gönderilmesi için trigger oluştur
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totalSeconds), repeats: true)
            
            // Bildirimi ekle
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            // Eğer şu an sessiz saatler arasındaysa, bir sonraki uygun zaman dilimine ileriye al
            while isWithinSilenceHours(date: nextTriggerDate, startHour: startSilenceHour, endHour: endSilenceHour) {
                nextTriggerDate = nextTriggerDate.addingTimeInterval(TimeInterval(totalSeconds))
            }
            
            // Bildirimlerin belirli bir sıklıkta gönderilmesi için trigger oluştur
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: nextTriggerDate.timeIntervalSinceNow, repeats: false)
            
            // Bildirimi ekle
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    func isWithinSilenceHours(date: Date, startHour: Int, endHour: Int) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date)
        let hour = components.hour!
        
        if startHour <= endHour {
            return hour >= startHour && hour < endHour
        } else {
            return hour >= startHour || hour < endHour
        }
    }
    func updateTime(hour: Int, minute: Int) {
        self.selectedH = hour
        self.selectedM = minute
    }
}
