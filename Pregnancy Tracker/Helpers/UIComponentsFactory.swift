//
//  UIComponentsFactory.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 2.04.2024.
//

import UIKit
import JGProgressHUD

class UIComponentsFactory {
    
    static func createCustomButton(title: String, state: UIControl.State, titleColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius:  CGFloat, clipsToBounds: Bool, action: (() -> Void)? = nil) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: state)
        button.setTitleColor(titleColor, for: .normal)
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
        button.clipsToBounds = clipsToBounds
        button.translatesAutoresizingMaskIntoConstraints = false
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
        textfield.clipsToBounds = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }
    static func createCustomCollectionView(scrollDirection: UICollectionView.ScrollDirection, bg: UIColor, spacing: CGFloat) -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = bg
        return collectionView
    }
    static func createCustomCalendarView() -> UIDatePicker{
        let datePicker = UIDatePicker()
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)
        datePicker.datePickerMode = .date
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        return datePicker
    }
    static func createCustomTextView(textSize: CGFloat, borderColor: CGColor) -> UITextView {

        let view = UITextView()
        view.textColor = UIColor.black
        view.font = FontHelper.customFont(size: textSize)
        view.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 0, right: 0)
        view.textColor = .black
        view.tintColor = .black
        view.textAlignment = .left
        view.backgroundColor = .white
        view.layer.borderColor = borderColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 5.0
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }
    static func createCustomPlaceholderLabel(text: String, textColor: UIColor, isHidden: Bool) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.isHidden = isHidden
        return label
    }
}
