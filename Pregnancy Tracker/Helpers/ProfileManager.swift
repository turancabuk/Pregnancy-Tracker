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
    func laodUserProfile() -> UserInfoModel {
        
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
    fileprivate func showAlert(from controller: UIViewController, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        controller.present(alert, animated: true)
    }
}

//    func userDefaultsProfileManager(from controller: UIViewController, nameTextfield: UITextField, profileImageView: UIImageView, datePicker: UIDatePicker) {
//        guard let name = nameTextfield.text, !name.isEmpty else {
//            self.showAlert(from: controller, message: "please enter your name")
//            return
//        }
//        guard let profileImage = profileImageView.image, profileImage != UIImage(systemName: "person.crop.circle.badge.plus") else {
//            self.showAlert(from: controller, message: "Please select a profile image")
//            return
//        }
//
//        if let imageData = profileImage.jpegData(compressionQuality: 1.0) {
//            defaults.set(imageData, forKey: "profileImage")
//        }else{
//            showAlert(from: controller, message: "please select a profile image")
//        }
//
//        defaults.set(name, forKey: "userName")
//
//        let pregnancyDateData = try? NSKeyedArchiver.archivedData(withRootObject: datePicker.date, requiringSecureCoding: false)
//        defaults.set(pregnancyDateData, forKey: "pregnancyDate")
//
//        defaults.synchronize()
//    }
