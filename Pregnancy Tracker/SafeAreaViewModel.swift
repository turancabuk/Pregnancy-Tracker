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
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidUpdate), name: .userDataDidUpdate, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func userDataDidUpdate() {
        DispatchQueue.main.async {
            self.loadUserData()
        }
    }
    private func loadUserData() {
        
        DispatchQueue.main.async {
            
            let userName = self.userDefaults.string(forKey: "userName") ?? "Unknown User"
            let profileImageData = self.userDefaults.data(forKey: "profileImage")
            let profileImage = profileImageData != nil ? UIImage(data: profileImageData!) : nil
            
            var pregnancyWeek: String?
            if let dateData = self.userDefaults.data(forKey: "pregnancyDate"),
               let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dateData) as? Date {
                let weeks = Calendar.current.dateComponents([.weekOfYear], from: savedDate, to: Date()).weekOfYear ?? 0
                pregnancyWeek = "\(weeks + 1) weeks"
            }
            
            var birthDate: String?
            if let savedDateData = self.userDefaults.data(forKey: "pregnancyDate"),
               let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedDateData) as? Date {
                birthDate = self.updateBirthday(date: savedDate)
            }
            self.model = UserInfoModel(userName: userName, profileImage: profileImage, pregnancyWeek: pregnancyWeek, birthDate: birthDate)
        }
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
