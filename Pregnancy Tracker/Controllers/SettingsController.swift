//
//  SettingsController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit


class SettingsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        setCustomView()
        addButtons()
        
    }
    
    func setCustomView() {
        let custumView = CustomView(frame: view.bounds)
        custumView.backgroundColorOption = .settingsColor
        view.addSubview(custumView)
        
    }
    
    func addButtons() {
           let buttonNames = ["shareButton", "rateButton", "privacyButton", "contactButton"]
           let buttonTitles = ["Share", "Rate", "Privacy", "Contact"]
           
           for (index, name) in buttonNames.enumerated() {
               let button = UIButton()
               button.setImage(UIImage(named: name), for: .normal)
               button.setTitle(buttonTitles[index], for: .normal)
               
               // Buton boyutlarını ve konumunu ayarla
               let screenWidth = UIScreen.main.bounds.width
               let screenHeight = UIScreen.main.bounds.height
               let buttonHeight = screenHeight * 0.1
               let buttonWidth = screenWidth * 0.8
               let buttonSpacing: CGFloat = 10
               let buttonY = CGFloat(index) * (buttonHeight + buttonSpacing) + 100 // 100 üstünden başlayarak alt alta sırala
               button.frame = CGRect(x: (screenWidth - buttonWidth) / 2, y: buttonY, width: buttonWidth, height: buttonHeight)

               switch name {
               case "shareButton":
                   button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
               case "rateButton":
                   button.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
               case "privacyButton":
                   button.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
               case "contactButton":
                   button.addTarget(self, action: #selector(contactTapped), for: .touchUpInside)
               default:
                   break
               }
               view.addSubview(button)
           }
       }
    
    func setButtons() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let buttonHeight = screenHeight * 0.08
        let buttonWidth = screenWidth * 0.8
        let bottomMargin = screenHeight * 0.15
        let buttonSpacing: CGFloat = 1
        
        let buttonNames = ["shareButton", "rateButton", "privacyButton", "contactButton"]
        
        for (index, name) in buttonNames.enumerated() {
            let button = UIButton()
            button.setImage(UIImage(named: name), for: .normal)
            
            let buttonY = screenHeight - bottomMargin - buttonHeight * CGFloat(index + 1) - buttonSpacing * CGFloat(index)
            button.frame = CGRect(x: (screenWidth - buttonWidth) / 2, y: buttonY, width: buttonWidth, height: buttonHeight)
            
            view.addSubview(button)
        }
    }

    
    @objc func shareTapped() {
        
    }

    @objc func rateTapped() {
       
    }

    @objc func privacyTapped() {
        
    }

    @objc func contactTapped() {
        
    }
    
    @objc func shareButtonTapped() {
        print("share button tapped")
        
    }
}
