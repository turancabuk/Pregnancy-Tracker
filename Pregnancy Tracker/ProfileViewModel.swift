//
//  ProfileViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 22.04.2024.
//

import UIKit

class ProfileViewModel {
    
    var defaults = UserDefaults.standard
    var userInfo: UserInfoModel {
        didSet{
            updateUI?()
        }
    }
    var profileManager: ProfileManager
    var updateUI: (() -> Void)?
    
    init(profileManager: ProfileManager) {
        self.profileManager = profileManager
        self.userInfo =  UserInfoModel()
        loadUserProfile {
            self.updateUI?()
        }
    }
    func loadUserProfile(completion: @escaping () -> Void ) {
        DispatchQueue.global(qos: .background).async {
            let loadedProfile = self.profileManager.loadUserProfile()
            DispatchQueue.main.async {
                self.userInfo = loadedProfile
                completion()
            }
        }
    }
}
