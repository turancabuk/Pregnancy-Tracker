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
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = clipsToBounds
        
        if let action = action {
            button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        }

        return button
    }
    
    static func createCustomTextfield(placeHolder: String, fontSize: CGFloat, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) -> UITextField{
        let textfield = UITextField()
        textfield.placeholder = placeHolder
        textfield.font = FontHelper.customFont(size: fontSize)
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.tintColor = .black
        textfield.layer.borderColor = borderColor.cgColor
        textfield.layer.borderWidth = borderWidth
        textfield.layer.cornerRadius = cornerRadius
        textfield.paddingLeft(padding: 10)
        textfield.clipsToBounds = true
        return textfield
    }
}
