//
//  ProfileManager.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 16.04.2024.
//

import UIKit

class ProfileManager {
    
    let defaults = UserDefaults.standard
    
    func saveUserProfile(model: UserInfoModel, completion: (Bool) -> Void) {
        
        guard let imageData = model.profileImage?.jpegData(compressionQuality: 1.0) else {
            completion(false)
            return
        }
        
        defaults.set(imageData, forKey: "profileImage")
        defaults.set(model.userName, forKey: "userName")
        
        if let date = model.lastMenstrualPeriod {
            let dateData = try? NSKeyedArchiver.archivedData(withRootObject: date, requiringSecureCoding: false)
            defaults.setValue(dateData, forKey: "pregnancyDate")
        }
        defaults.synchronize()
        completion(true)
    }
    func loadUserProfile() -> UserInfoModel {
        let userName = defaults.string(forKey: "userName") ?? ""
        let profileImageData = defaults.data(forKey: "profileImage")
        let profileImage = profileImageData != nil ? UIImage(data: profileImageData!) : nil

        var lastMenstrualPeriod: Date?
        if let dateData = defaults.data(forKey: "pregnancyDate"),
           let date = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dateData) as? Date {
            lastMenstrualPeriod = date
        }
        return UserInfoModel(userName: userName, profileImage: profileImage, lastMenstrualPeriod: lastMenstrualPeriod)
    }
}


//yukarıda verdiğin bilgiler ve önerilere dayanarak ProfileController class'ımı MVVM mimarisine çevirdim.
//
//Bu sayede PersonalInformation'da kullanıcının girdiği değerleri userDefaults'a kaydedip, ProfileController'daki imageView ve nameTextfield değerlerini doldurup kullanıcıyı gösterebiliyorum.
//
//Şimdi senden isteğim şu:
//Kullanıcı ProfileController'da userDefaults'dan çekip gösterdiğim değerleri (userName, profileImage, lastMenstrualPeriod)  güncelleyebilisin.
//
//işte ProfileController class'ımın güncel ve tam hali:
