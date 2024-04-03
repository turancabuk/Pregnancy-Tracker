//
//  CalendarDetailController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit
import CoreData
import EventKit

class CalendarDetailController: UIViewController, UITextViewDelegate {
    
    let customColor = UIColor(hex: "F2B5D4")
    let eventStore = EKEventStore()
    let entityName = "Doctor"
    var managedObjectContext: NSManagedObjectContext?

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
        let datePicker = UIComponentsFactory.createCustomCalendarView()
        datePicker.addTarget(self, action: #selector(dayTapped), for: .valueChanged)
        return datePicker
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
    
    lazy var aboutTextfield = UIComponentsFactory.createCustomTextfield(placeHolder: "Note About", fontSize: 18, borderColor: .white, borderWidth: 3.0, cornerRadius: 12)
    
    lazy var saveButton = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: .white, borderColor: .white, borderWidth: 3.0, cornerRadius: 16, clipsToBounds: true, action: saveButtonTapped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        
    }
    func disableAutoResizingMaskConstraints(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func enableUserInteraction(for views: [UIView]) {
        views.forEach { $0.isUserInteractionEnabled = true }
    }
    fileprivate func setupLayout() {
        
        disableAutoResizingMaskConstraints(for: [seperatorView, scrollView, contentView, calendarContainerView, calendarView, timePicker, aboutTextfield, noteView, placeHolderLabel, saveButton])
        
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
    @objc fileprivate func saveButtonTapped() {
        if #available(iOS 17.0, *) {
            eventStore.requestWriteOnlyAccessToEvents { [weak self] granted, error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if granted, error == nil {
                        // Granted, Contunie
                        if let aboutText = self.aboutTextfield.text, !aboutText.isEmpty,
                           let noteText = self.noteView.text {
                            
                            let selectedDate = self.calendarView.date
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
                                newItem.setValue(self.noteView.text, forKey: "note")
                                let dateIntValue = Int32(self.calendarView.date.timeIntervalSince1970)
                                let timeIntValue = Int32(self.timePicker.date.timeIntervalSince1970)
                                newItem.setValue(dateIntValue, forKey: "date")
                                newItem.setValue(timeIntValue, forKey: "time")
                                do {
                                    try context.save()
                                    if let CalendarViewController = self.presentingViewController as? CalendarViewController {
                                        CalendarViewController.addDataToCollectionView(newItem)
                                    }
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
                           let noteText = self.noteView.text {
                            
                            // Seçilen tarih ve saat
                            let selectedDate = self.calendarView.date
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
                                newItem.setValue(self.noteView.text, forKey: "note")
                                let dateIntValue = Int32(self.calendarView.date.timeIntervalSince1970)
                                let timeIntValue = Int32(self.timePicker.date.timeIntervalSince1970)
                                newItem.setValue(dateIntValue, forKey: "date")
                                newItem.setValue(timeIntValue, forKey: "time")
                                do {
                                    try context.save()
                                    if let CalendarViewController = self.presentingViewController as? CalendarViewController {
                                        CalendarViewController.addDataToCollectionView(newItem)
                                    }
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

