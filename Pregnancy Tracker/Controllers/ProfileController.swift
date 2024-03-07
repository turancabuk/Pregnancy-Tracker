//
//  ProfileController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class ProfileController: UIViewController {
    
    let personalCardColor = #colorLiteral(red: 0.6998794675, green: 0.9681568742, blue: 0.9384742975, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLayout()
        
    }
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        let safeAreaView = SafeAreaView(frame: view.bounds)
        safeAreaView.setPersonelView(backgroundColor: personalCardColor)
        view.addSubview(safeAreaView)
    }
}
