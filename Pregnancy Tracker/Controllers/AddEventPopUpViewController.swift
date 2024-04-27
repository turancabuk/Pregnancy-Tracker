//
//  AddEventPopUpViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 5.04.2024.
//

import UIKit
import CoreData
import EventKit

protocol AddEventPopUpViewControllerDelegate: AnyObject {
    func didAddEvent()
}
class AddEventPopUpViewController: UIViewController, UITextViewDelegate, AddEventViewModelDelegate {
    
    
    
    var viewModel = AddEventViewModel()
    var selectedDateFromCalendar: Date?
    let eventStore = EKEventStore()
    let entityName = "Doctor"
    var managedObjectContext: NSManagedObjectContext?
    var selectedDate: Date?
    weak var delegate: AddEventPopUpViewControllerDelegate?
    
    
    lazy var timePickerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "ffc2b4")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        return timePicker
    }()
    
    lazy var aboutTextfield: UITextField = {
        let textfield = UIComponentsFactory.createCustomTextfield(placeHolder: "Note about", fontSize: 16, borderColor: .black, borderWidth: 2.0, cornerRadius: 12)
        textfield.paddingLeft(padding: 12)
        return textfield
    }()
    
    lazy var noteTextview: UITextView = {
        let textview = UIComponentsFactory.createCustomTextView(textSize: 16, borderColor: UIColor.black.cgColor)
        textview.delegate = self
        return textview
    }()
    
    lazy var placeholderLabel = UIComponentsFactory.createCustomPlaceholderLabel(text: "Your notes", textColor: .lightGray, isHidden: false)
    lazy var saveButton = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: .white, borderColor: .black, borderWidth: 1.0, cornerRadius: 6, clipsToBounds: true, action: handleSave)
    lazy var cancelButton = UIComponentsFactory.createCustomButton(title: "Cancel", state: .normal, titleColor: .white, borderColor: .black, borderWidth: 1.0, cornerRadius: 4, clipsToBounds: true, action: handleCancel)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupLayout()
        registerKeyboardNotifications()
        delegate?.didAddEvent()

        
    }
    func dismiss() {
        dismiss(animated: true)
    }
    func didAddEvent() {
        delegate?.didAddEvent()
        
        dismiss(animated: true)
    }
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func didSelectDate(date: Date) {
        
        viewModel.selectedDate = date
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !noteTextview.text.isEmpty
    }
    @objc fileprivate func handleCancel() {
        self.dismiss(animated: true)
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        var shouldMoveViewUp = false

        let bottomOfTextField = aboutTextfield.convert(aboutTextfield.bounds, to: self.view).maxY
        let bottomOfTextView = noteTextview.convert(noteTextview.bounds, to: self.view).maxY
        let topOfKeyboard = self.view.frame.height - keyboardSize.height

        if aboutTextfield.isFirstResponder && bottomOfTextField > topOfKeyboard {
            shouldMoveViewUp = true
        } else if noteTextview.isFirstResponder && bottomOfTextView > topOfKeyboard {
            shouldMoveViewUp = true
        }
        if shouldMoveViewUp {
            self.view.frame.origin.y = 0 - keyboardSize.height / 2
        }
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    func showAlert(title: String, describe: String) {
        let alert = UIAlertController(title: title, message: describe, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
    func didFailWithError(message: String) {
        showAlert(title: "Error", describe: message)
    }
    @objc fileprivate func handleSave() {
        
        guard let aboutText = aboutTextfield.text, !aboutText.isEmpty,
              let noteText = noteTextview.text, !noteText.isEmpty else {
            showAlert(title: "Error", describe: "Lütfen Tüm alanları doldurun")
            return
        }
        viewModel.addEvent(aboutText: aboutText, noteText: noteText, selectedTime: timePicker.date)
    }
}

extension UITextField {
    func paddingLeft(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
extension AddEventPopUpViewController {
    fileprivate func setupLayout(){
        self.preferredContentSize = CGSize(width: 320, height: 360)
        view.addSubview(timePickerContainerView)
        timePickerContainerView.addSubview(timePicker)
        timePickerContainerView.addSubview(aboutTextfield)
        timePickerContainerView.addSubview(noteTextview)
        noteTextview.addSubview(placeholderLabel)
        timePickerContainerView.addSubview(saveButton)
        timePickerContainerView.addSubview(cancelButton)
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        aboutTextfield.translatesAutoresizingMaskIntoConstraints = false
        noteTextview.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timePickerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePickerContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            timePickerContainerView.widthAnchor.constraint(equalToConstant: preferredContentSize.width),
            timePickerContainerView.heightAnchor.constraint(equalToConstant: preferredContentSize.height),
            
            timePicker.topAnchor.constraint(equalTo: timePickerContainerView.topAnchor, constant: 6),
            timePicker.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 1/3),
            timePicker.heightAnchor.constraint(equalTo: timePickerContainerView.heightAnchor, multiplier: 1/3),
            timePicker.centerXAnchor.constraint(equalTo: timePickerContainerView.centerXAnchor),
            
            aboutTextfield.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 6),
            aboutTextfield.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 3/4),
            aboutTextfield.leadingAnchor.constraint(equalTo: timePickerContainerView.leadingAnchor, constant: 12),
            aboutTextfield.heightAnchor.constraint(equalTo: timePickerContainerView.heightAnchor, multiplier: 1/6),
            
            noteTextview.topAnchor.constraint(equalTo: aboutTextfield.bottomAnchor, constant:  6),
            noteTextview.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 3/4),
            noteTextview.leadingAnchor.constraint(equalTo: timePickerContainerView.leadingAnchor, constant: 12),
            noteTextview.heightAnchor.constraint(equalTo: timePickerContainerView.heightAnchor, multiplier: 1/3),
            
            placeholderLabel.topAnchor.constraint(equalTo: noteTextview.topAnchor),
            placeholderLabel.widthAnchor.constraint(equalTo: noteTextview.widthAnchor, multiplier: 2/3),
            placeholderLabel.leadingAnchor.constraint(equalTo: noteTextview.leadingAnchor, constant: 8),
            placeholderLabel.heightAnchor.constraint(equalTo: noteTextview.heightAnchor, multiplier: 1/3),
            
            saveButton.topAnchor.constraint(equalTo: noteTextview.bottomAnchor, constant: 6),
            saveButton.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 1/5),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.centerXAnchor.constraint(equalTo: timePickerContainerView.centerXAnchor, constant: 48),
            
            cancelButton.topAnchor.constraint(equalTo: noteTextview.bottomAnchor, constant: 6),
            cancelButton.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 1/5),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.centerXAnchor.constraint(equalTo: timePickerContainerView.centerXAnchor, constant: -48),
        ])
    }
}
