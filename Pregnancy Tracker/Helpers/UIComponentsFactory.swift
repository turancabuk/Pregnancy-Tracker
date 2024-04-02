//
//  UIComponentsFactory.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 2.04.2024.
//

import UIKit

class UIComponentsFactory {
    
    static func createCustomButton(title: String, state: UIControl.State, titleColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius:  CGFloat, clipsToBounds: Bool, action: (() -> Void)? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: state)
        button.setTitleColor(titleColor, for: .normal)
//        button.backgroundColor = backgroundColor
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = clipsToBounds
        
        if let action = action {
            button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        }

        return button
    }
}

//let saveButton = UIButton(type: .system)
//saveButton.setTitle("Save", for: .normal)
//saveButton.setTitleColor(.white, for: .normal)
//saveButton.layer.borderColor = personalCardColor.cgColor
//saveButton.layer.borderWidth = 3.0
//saveButton.layer.cornerRadius = 16
//saveButton.clipsToBounds = true
//saveButton.translatesAutoresizingMaskIntoConstraints = false
//saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
