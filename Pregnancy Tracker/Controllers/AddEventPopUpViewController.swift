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
class AddEventPopUpViewController: UIViewController, UITextViewDelegate, CalendarViewControllerDelegate {
    
    
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
    
    lazy var placeholderLabel: UILabel = {
        let placeholder = UIComponentsFactory.createCustomPlaceholderLabel(text: "Your notes", textColor: .lightGray, isHidden: false)
        return placeholder
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: .lightGray, borderColor: .black, borderWidth: 1.0, cornerRadius: 6, clipsToBounds: true, action: handleSave)
        button.backgroundColor = .white
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "Cancel", state: .normal, titleColor: .lightGray, borderColor: .black, borderWidth: 1.0, cornerRadius: 4, clipsToBounds: true, action: handleCancel)
        button.backgroundColor = .white
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedObjectContext = appDelegate.persistentContainer.viewContext
        }
    }
    func didSelectDate(date: Date) {
        self.selectedDate = date
    }
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
            aboutTextfield.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 2/3),
            aboutTextfield.leadingAnchor.constraint(equalTo: timePickerContainerView.leadingAnchor, constant: 12),
            aboutTextfield.heightAnchor.constraint(equalTo: timePickerContainerView.heightAnchor, multiplier: 1/6),
            
            noteTextview.topAnchor.constraint(equalTo: aboutTextfield.bottomAnchor, constant:  6),
            noteTextview.widthAnchor.constraint(equalTo: timePickerContainerView.widthAnchor, multiplier: 2/3),
            noteTextview.leadingAnchor.constraint(equalTo: timePickerContainerView.leadingAnchor, constant: 12),
            noteTextview.heightAnchor.constraint(equalTo: timePickerContainerView.heightAnchor, multiplier: 1/3),
            
            placeholderLabel.topAnchor.constraint(equalTo: noteTextview.topAnchor, constant: 4),
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
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !noteTextview.text.isEmpty
    }
    @objc fileprivate func handleCancel() {
        self.dismiss(animated: true)
    }
    @objc fileprivate func handleSave() {
        
       
        if #available(iOS 17.0, *) {
            eventStore.requestWriteOnlyAccessToEvents { [weak self] granted, error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if granted, error == nil {
                        // Granted, Contunie
                        if let aboutText = self.aboutTextfield.text, !aboutText.isEmpty,
                           let noteText = self.noteTextview.text {
                            
                            let selectedDate = self.selectedDate!
                            let selectedTime = self.timePicker.date
                            
                            let calendar = Calendar.current
                            let now = Date()
                            let halfHourLater = calendar.date(byAdding: .minute, value: 30, to: now)!
                            
                            let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
                            let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
                            let combinedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)
                            
                            if let eventDate = calendar.date(from: combinedComponents), eventDate >= halfHourLater {
                                
                                // Add Event to Calendar
                                self.addEventToCalendar(title: aboutText, description: noteText, startDate: eventDate)
                            } else {
                                let alert = UIAlertController(title: "Eror", message: "Half hour Error", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                            // Add to Coredata
                            if let context = self.managedObjectContext, let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) {
                                let newItem = NSManagedObject(entity: entity, insertInto: context)
                                newItem.setValue(self.aboutTextfield.text, forKey: "about")
                                newItem.setValue(self.noteTextview.text, forKey: "note")
                                let dateIntValue = Int32(self.selectedDate!.timeIntervalSince1970)
                                let timeIntValue = Int32(self.timePicker.date.timeIntervalSince1970)
                                newItem.setValue(dateIntValue, forKey: "date")
                                newItem.setValue(timeIntValue, forKey: "time")
                                do {
                                    try context.save()
                                    if let CalendarViewController = self.presentingViewController as? CalendarViewController {
                                        CalendarViewController.addDataToCollectionView(newItem)
                                    }
                                    self.delegate?.didAddEvent()
                                    self.dismiss(animated: true, completion: nil)
                                } catch let _ as NSError {
                                    // Hata yönetimi
                                }
                            }
                        }
                    } else {
                        // İzin verilmedi veya hata oluştu, gerekli işlemleri burada yapın.
                        print("Calendar access not granted or an error occurred: \(error?.localizedDescription ?? "Unknown error")")
                        let alert = UIAlertController(title: "Error", message: "Grant Error", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            // iOS 17 öncesi cihazlar için
            eventStore.requestAccess(to: .event) { [weak self] granted, error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if granted, error == nil {
                        // İzin verildi, işlemleri burada devam ettirin.
                        if let aboutText = self.aboutTextfield.text, !aboutText.isEmpty,
                           let noteText = self.noteTextview.text {
                            
                            // Seçilen tarih ve saat
                            let selectedDate = self.selectedDate!
                            let selectedTime = self.timePicker.date
                            
                            let calendar = Calendar.current
                            let now = Date()
                            let halfHourLater = calendar.date(byAdding: .minute, value: 30, to: now)!
                            
                            let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
                            let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
                            let combinedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)
                            
                            if let eventDate = calendar.date(from: combinedComponents), eventDate >= halfHourLater {
                                
                                // Etkinliği takvime ekleme işlemi
                                self.addEventToCalendar(title: aboutText, description: noteText, startDate: eventDate)
                            } else {
                                let alert = UIAlertController(title: "Error", message: "Half hour Error", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                            // Coredata'ya ekleme işlemi
                            if let context = self.managedObjectContext, let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context) {
                                let newItem = NSManagedObject(entity: entity, insertInto: context)
                                newItem.setValue(self.aboutTextfield.text, forKey: "about")
                                newItem.setValue(self.noteTextview.text, forKey: "note")
                                let dateIntValue = Int32(self.selectedDate!.timeIntervalSince1970)
                                let timeIntValue = Int32(self.timePicker.date.timeIntervalSince1970)
                                newItem.setValue(dateIntValue, forKey: "date")
                                newItem.setValue(timeIntValue, forKey: "time")
                                do {
                                    try context.save()
                                    if let CalendarViewController = self.presentingViewController as? CalendarViewController {
                                        CalendarViewController.addDataToCollectionView(newItem)
                                    }
                                    self.delegate?.didAddEvent()
                                    self.dismiss(animated: true, completion: nil)
                                } catch let _ as NSError {
                                    // Hata yönetimi
                                }
                            }
                        }
                    } else {
                        // İzin verilmedi veya hata oluştu, gerekli işlemleri burada yapın.
                        print("Calendar access not granted or an error occurred: \(error?.localizedDescription ?? "Unknown error")")
                        let alert = UIAlertController(title: "Error", message: "Grant Alert", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    func addEventToCalendar(title: String, description: String, startDate: Date) {
        if #available(iOS 17.0, *) {
            eventStore.requestWriteOnlyAccessToEvents { [weak self] granted, error in
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    if granted, error == nil {
                        let event = EKEvent(eventStore: strongSelf.eventStore)
                        event.title = title
                        event.startDate = startDate
                        event.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)
                        event.notes = description
                        event.calendar = strongSelf.eventStore.defaultCalendarForNewEvents
                        
                        let alarm = EKAlarm(relativeOffset: -15 * 60)
                        event.addAlarm(alarm)
                        
                        do {
                            try strongSelf.eventStore.save(event, span: .thisEvent)
                            // Hatırlatıcı başarıyla eklendi, kullanıcıya bilgi verebilirsiniz.
                            let alert = UIAlertController(title: "Succes", message: "Reminder added", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            strongSelf.present(alert, animated: true, completion: nil)
                        } catch let error as NSError {
                            print("Error saving event to calendar: \(error)")
                            // Hata durumunda kullanıcıya bilgi verin
                            let alert = UIAlertController(title: "Error", message: "Reminder Alert", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            strongSelf.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        print("Calendar access not granted or an error occurred: \(error?.localizedDescription ?? "Unknown error")")
                        // İzin verilmedi veya hata durumunda kullanıcıya bilgi verin
                        let alert = UIAlertController(title: "Error", message: "Grant Error", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        strongSelf.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else {
            // iOS 17 öncesi cihazlar için
            addEventToCalendarForOldiOS(title: title, description: description, startDate: startDate)
        }
    }
    func addEventToCalendarForOldiOS(title: String, description: String, startDate: Date) {
        eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
            guard let strongSelf = self, granted, error == nil else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Hata", message: "Takvim erişim izni verilmedi.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            let event = EKEvent(eventStore: strongSelf.eventStore)
            event.title = title
            event.startDate = startDate
            event.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)
            event.notes = description
            event.calendar = strongSelf.eventStore.defaultCalendarForNewEvents
            
            let alarm = EKAlarm(relativeOffset: -15 * 60)
            event.addAlarm(alarm)
            
            do {
                try strongSelf.eventStore.save(event, span: .thisEvent)
                DispatchQueue.main.async {
                    // Hatırlatıcı başarıyla eklendi, kullanıcıya bilgi verebilirsiniz.
                    let alert = UIAlertController(title: "Succes", message: "Reminder Alert", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            } catch let error as NSError {
                DispatchQueue.main.async {
                    print("Error saving event to calendar: \(error)")
                    // Hata durumunda kullanıcıya bilgi verin
                    let alert = UIAlertController(title: "Error", message: "Reminder Alert", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
extension UITextField {
    func paddingLeft(padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}