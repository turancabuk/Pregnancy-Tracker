//
//  PersonalInformationViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 21.04.2024.
//

import UIKit

class PersonalInformationViewModel {
    
    var personalInformationModel: UserInfoModel
    var profileManager: ProfileManager
    var showError: ((String) -> Void)
    
    
    init(personalInformationModel: UserInfoModel, profileManager: ProfileManager, showError: @escaping (String) -> Void) {
        
        self.personalInformationModel = personalInformationModel
        self.profileManager = profileManager
        self.showError = showError
    }
    func saveProfile(name: String?, profileImage: UIImage?, date: Date?) {
        guard let name = name, !name.isEmpty else {
            showError("Please Enter your name")
            return
        }
        guard let profileImage = profileImage, profileImage != UIImage(systemName: "person.crop.circle.badge.plus") else {
            showError("please select a photo")
            return
        }
        DispatchQueue.main.async {
            self.personalInformationModel.userName = name
            self.personalInformationModel.profileImage = profileImage
            self.personalInformationModel.lastMenstrualPeriod = date
            
            self.profileManager.saveUserProfile(model: self.personalInformationModel) { [weak self] succes in
                
                if !succes {
                    self?.showError("Profile not save")
                }else{
                    print("error:")
                }
            }
        }
    }
}
