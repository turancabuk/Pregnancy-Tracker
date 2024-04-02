//
//  CalendarController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class CalendarController: UIViewController, UITextViewDelegate {
    
    let customColor = UIColor(hex: "F2B5D4")
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var calendarView: UIDatePicker = {
        let view = UIDatePicker()
        view.isUserInteractionEnabled = true
        let currentDate = Date()
        view.minimumDate = currentDate
        view.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)
        view.datePickerMode = .date
        view.addTarget(self, action: #selector(dayTapped), for: .valueChanged)
        return view
    }()
    
    lazy var calendarContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3.0
        return view
    }()
    
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.layer.borderColor = UIColor.white.cgColor
        timePicker.layer.borderWidth = 3.0
        return timePicker
    }()
    
    lazy var aboutTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Note about"
        textfield.font = FontHelper.customFont(size: 18)
        textfield.backgroundColor = .white
        textfield.textColor = .black
        textfield.tintColor = .black
        textfield.layer.borderColor = customColor.cgColor
        textfield.layer.borderWidth = 2.0
        textfield.layer.cornerRadius = 5.0
        textfield.paddingLeft(padding: 10)
        textfield.layer.cornerRadius = 12
        textfield.clipsToBounds = true
        return textfield
    }()
    
    lazy var noteView: UITextView = {
        let view = UITextView()
        view.delegate = self
        view.textColor = .black
        view.font = FontHelper.customFont(size: 16)
        view.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 0, right: 0)
        view.textColor = .black
        view.tintColor = .black
        view.textAlignment = .left
        view.backgroundColor = .white
        view.layer.borderColor = customColor.cgColor
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 5.0
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Notes"
        label.textColor = .lightGray
        label.isHidden = false
        return label
    }()
    
//    lazy var saveButton = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, backgroundColor: .white, titleColor: customColor, cornerRadius: 5, clipsToBounds: true)
    
    lazy var saveButton = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: .white, borderColor: .white, borderWidth: 3.0, cornerRadius: 16, clipsToBounds: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
    }   
    fileprivate func setupLayout() {
        tabBarController?.tabBar.backgroundColor = .white
        view.backgroundColor = customColor
        view.addSubview(seperatorView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendarView)
        contentView.addSubview(timePicker)
        contentView.addSubview(aboutTextfield)
        contentView.addSubview(noteView)
        noteView.addSubview(placeHolderLabel)
        contentView.addSubview(saveButton)
        
        if #available(iOS 13.4, *) {
            calendarView.preferredDatePickerStyle = .inline
        }
        
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        calendarContainerView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        aboutTextfield.translatesAutoresizingMaskIntoConstraints = false
        noteView.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        calendarView.isUserInteractionEnabled = true
        timePicker.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        aboutTextfield.isUserInteractionEnabled = true
        noteView.isUserInteractionEnabled = true
        saveButton.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            
            seperatorView.topAnchor.constraint(equalTo: view.topAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            calendarContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            calendarContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            calendarContainerView.heightAnchor.constraint(equalToConstant: 400),
            
            calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            
            timePicker.topAnchor.constraint(equalTo: calendarContainerView.bottomAnchor, constant: 12),
            timePicker.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 200),
            
            aboutTextfield.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 12),
            aboutTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            aboutTextfield.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3),
            aboutTextfield.heightAnchor.constraint(equalToConstant: 30),
            
            noteView.topAnchor.constraint(equalTo: aboutTextfield.bottomAnchor, constant: 12),
            noteView.leadingAnchor.constraint(equalTo: aboutTextfield.leadingAnchor),
            noteView.widthAnchor.constraint(equalTo: aboutTextfield.widthAnchor),
            noteView.heightAnchor.constraint(equalToConstant: 100),
            
            placeHolderLabel.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 8),
            placeHolderLabel.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 8),
            placeHolderLabel.widthAnchor.constraint(equalTo: noteView.widthAnchor, multiplier: 1/2),
            placeHolderLabel.heightAnchor.constraint(equalTo: noteView.heightAnchor, multiplier: 1/4),
            
            saveButton.topAnchor.constraint(equalTo: noteView.bottomAnchor, constant: 12),
            saveButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
        if let lastView = contentView.subviews.last {
            NSLayoutConstraint.activate([
                lastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ])
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !noteView.text.isEmpty
    }
    @objc fileprivate func dayTapped() {
        print("day tapped ")
    }
}
extension UITextField {
    func paddingLeft(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
  
