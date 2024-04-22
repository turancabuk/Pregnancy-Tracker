//
//  SafeAreaViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 21.04.2024.
//

import UIKit

class SafeAreaViewModel {
    
    private let userDefaults = UserDefaults.standard
    var model: UserInfoModel?
    
    init() {
        loadUserData()
    }
    private func loadUserData() {
        let userDefaults = UserDefaults.standard
        let userName = userDefaults.string(forKey: "userName") ?? "Unknown User"
        let profileImageData = userDefaults.data(forKey: "profileImage")
        let profileImage = profileImageData != nil ? UIImage(data: profileImageData!) : nil
        
        var pregnancyWeek: String?
        if let dateData = userDefaults.data(forKey: "pregnancyDate"),
           let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dateData) as? Date {
            let weeks = Calendar.current.dateComponents([.weekOfYear], from: savedDate, to: Date()).weekOfYear ?? 0
            pregnancyWeek = "\(weeks + 1) weeks"
        }
        
        var birthDate: String?
        if let savedDateData = userDefaults.data(forKey: "pregnancyDate"),
           let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedDateData) as? Date {
            birthDate = updateBirthday(date: savedDate)
        }
        self.model = UserInfoModel(userName: userName, profileImage: profileImage, pregnancyWeek: pregnancyWeek ?? "0", birthDate: birthDate)
    }
    private func updateBirthday(date: Date) -> String {

        var components = DateComponents()
        components.month = 9
        components.day = 10
        if let futureDate = Calendar.current.date(byAdding: components, to: date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let futureDateString = dateFormatter.string(from: futureDate)
            return dateFormatter.string(from: futureDate)
        }
        return "date not set"
    }
}
