//
//  WaterViewViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 12.05.2024.
//

import UIKit

class WaterViewViewModel {
    
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
        saveDrinkQuantities()
    }
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
}
