//
//  SettingsViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 30.04.2024.
//

import UIKit

class SettingsViewModel {
  
    func shareButtonConfgs() {
        print("share button tapped")
        // Appstore'dan adres alındıktan sonra güncellenecek.
    }
    func rateButtonConfgs() {
        print("rate button tapped")
        // Appstore'dan adres alındıktan sonra güncellenecek.
    }
    func contactButtonConfgs() {
        if let url = URL(string: "https://www.linkedin.com/in/turancabuk/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func privacyButtonConfgs() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/aa86aece-5f15-4c8f-9a43-41e3f8fe8859") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func advertViewContact() {
        if let url = URL(string: "https://apps.apple.com/us/app/little-steps-development/id6474306976") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
