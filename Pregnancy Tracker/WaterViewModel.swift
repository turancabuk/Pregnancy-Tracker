//
//  WaterViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 12.05.2024.
//

import UIKit

class WaterViewModel {
    
    var drinkQunatities: [String: Int] = ["water": 0, "coffee": 0, "juice": 0, "tea": 0]

    init() {
        loadDrinkQunatities()
    }
    
    func loadDrinkQunatities() {
        if let savedQuantities = UserDefaults.standard.dictionary(forKey: "SaveDrinkQuantities") as? [String: Int] {
            drinkQunatities = savedQuantities
        }
    }
    func saveDrinkQuantities() {
        UserDefaults.standard.set(drinkQunatities, forKey: "SaveDrinkQuantities")
        UserDefaults.standard.synchronize()
    }
    func resetDrinkQuantities() {
        drinkQunatities = ["water": 0, "coffee": 0, "juice": 0, "tea": 0]
    }
    
    func setupDailyResetTimer() {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 13
        dateComponents.minute = 18
        dateComponents.second = 0
        
        let today = Date()
        let sevenAMToday = calendar.nextDate(after: today, matching: dateComponents, matchingPolicy: .nextTime)!
        let timeInterval = sevenAMToday.timeIntervalSinceNow
        
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { [weak self] _ in
            DispatchQueue.main.async {
                self?.resetDrinkQuantities()
            }
        }
    }
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
}
