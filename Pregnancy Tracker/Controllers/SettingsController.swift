//
//  SettingsController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit


class SettingsController: UIViewController {
    
    let shareButton: SettingsPageButtons = {
        let button = SettingsPageButtons()
        button.setTitle("Bizi Paylaşın", for: .normal)
        button.buttonState = .active
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        button.setCornerRadius(radius: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
               button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

               // Butonu ekrana ekle
               view.addSubview(button)
           }
       }
    
    func setButtons() {
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = UIScreen.main.bounds.height
            
            let buttonHeight = screenHeight * 0.1
            let buttonWidth = screenWidth * 0.8
            let bottomMargin = screenHeight * 0.15
            
            let shareButton = UIButton()
            shareButton.setImage(UIImage(named: "shareButton"), for: .normal)
            
            // Buton boyutlarını ayarla
            shareButton.frame = CGRect(x: (screenWidth - buttonWidth) / 2,
                                       y: screenHeight - bottomMargin - buttonHeight,
                                       width: buttonWidth,
                                       height: buttonHeight)
            
            // Butonu ekrana ekle
            view.addSubview(shareButton)
        }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        print("\(title) button tapped")
    }
    
    @objc func shareButtonTapped() {
        print("share button tapped")
        
    }
}
