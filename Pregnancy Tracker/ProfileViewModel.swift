//
//  ProfileViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 22.04.2024.
//

import UIKit

class ProfileViewModel {
    

    var profileManager: ProfileManager
    var userInfo: UserInfoModel 
    var updateUI: (() -> Void)?
    
    init() {
        self.profileManager = ProfileManager()
        self.userInfo =  UserInfoModel()
    }
    func saveUserProfile(userName: String?, profileImage: UIImage?, date: Date?) {
        
        self.userInfo.userName = userName
        self.userInfo.profileImage = profileImage
        self.userInfo.lastMenstrualPeriod = date
        
        self.profileManager.saveUserProfile(model: self.userInfo) { [weak self] succes in
            DispatchQueue.main.async {
                if succes {
                    self?.updateUI?()
                    NotificationCenter.default.post(name: .userDataDidUpdate, object: nil)
                }
            }
        }
    }
    func loadUserProfile(completion: @escaping () -> Void ) {
        let loadedProfile = self.profileManager.loadUserProfile()
        DispatchQueue.main.async {
            self.userInfo = loadedProfile
            completion()
        }
    }
}
extension Notification.Name {
    static let userDataDidUpdate = Notification.Name("userDataDidUpdate")
}
