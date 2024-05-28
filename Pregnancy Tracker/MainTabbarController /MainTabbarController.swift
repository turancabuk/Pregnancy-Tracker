//
//  MainTabbarController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileController = ProfileController()
        let homeController = HomeController()
        let waterController = WaterViewController()
        let calendarController = CalendarViewController()
        let settingsController = SettingsController()
        
        profileController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        homeController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "figure.yoga"), selectedImage: UIImage(systemName: "figure.yoga.fill"))
        waterController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "drop.degreesign"), selectedImage: UIImage(systemName: "drop.degreesign.fill"))
        calendarController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar.fill"))
        settingsController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        let controllers = [
            UINavigationController(rootViewController: profileController),
            UINavigationController(rootViewController: homeController),
            UINavigationController(rootViewController: waterController),
            UINavigationController(rootViewController: calendarController),
            UINavigationController(rootViewController: settingsController)
        ]
        
        self.viewControllers = controllers
        
        self.selectedIndex = 1
        self.tabBar.barTintColor = .blue
    }
}
