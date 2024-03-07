//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        
    }
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        let safeAreaView = SafeAreaView(frame: view.bounds)
        safeAreaView.setPersonelView(backgroundColor: .blue)
        view.addSubview(safeAreaView)
    }
}
