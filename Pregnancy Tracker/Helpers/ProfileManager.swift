//
//  ProfileManager.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 16.04.2024.
//

import UIKit

class ProfileManager {
    
    let defaults = UserDefaults.standard
    
    func userDefaultsProfileManager(from controller: UIViewController, nameTextfield: UITextField, profileImageView: UIImageView, datePicker: UIDatePicker) {
        guard let name = nameTextfield.text, !name.isEmpty else {
            self.showAlert(from: controller, message: "please enter your name")
            return
        }
        guard let profileImage = profileImageView.image, profileImage != UIImage(systemName: "person.crop.circle.badge.plus") else {
            self.showAlert(from: controller, message: "Please select a profile image")
            return
        }
        
        if let imageData = profileImage.jpegData(compressionQuality: 1.0) {
            defaults.set(imageData, forKey: "profileImage")
        }else{
            showAlert(from: controller, message: "please select a profile image")
        }
        
        defaults.set(name, forKey: "userName")
        
        let pregnancyDateData = try? NSKeyedArchiver.archivedData(withRootObject: datePicker.date, requiringSecureCoding: false)
        defaults.set(pregnancyDateData, forKey: "pregnancyDate")

        defaults.synchronize()
    }
    fileprivate func showAlert(from controller: UIViewController, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        controller.present(alert, animated: true)
    }
}
