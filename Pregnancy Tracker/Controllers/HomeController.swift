//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController {
    
    let personalCardColor = #colorLiteral(red: 0.9507680535, green: 0.7077944875, blue: 0.8335040212, alpha: 1)
    
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
