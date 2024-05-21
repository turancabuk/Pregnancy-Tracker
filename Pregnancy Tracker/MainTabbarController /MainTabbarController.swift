//
//  MainTabbarController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class MainTabbarController: UIViewController {
    
    let profileController = ProfileController()
    let homeController = HomeController()
    let waterController = WaterViewController()
    let calendarController = CalendarViewController()
    let settingsController = SettingsController()
    let MainBarController = UITabBarController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        homeController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "figure.yoga"), selectedImage: UIImage(systemName: "figure.yoga.fill"))
        waterController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "drop.degreesign"), selectedImage: UIImage(systemName: "drop.degreesign.fill"))
        calendarController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
        settingsController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
        
        MainBarController.viewControllers = [profileController, homeController, waterController, calendarController, settingsController]
        view.addSubview(MainBarController.view)
        MainBarController.didMove(toParent: self)
        
        MainBarController.selectedIndex = 1
        MainBarController.tabBar.barTintColor = .blue
        MainBarController.tabBar.layer.cornerRadius = 12
        MainBarController.tabBar.layer.masksToBounds = true
        
       
    }
}
