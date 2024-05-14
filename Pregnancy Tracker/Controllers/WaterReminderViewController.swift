//
//  WaterReminderViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 13.05.2024.
//

import UIKit
import UserNotifications

protocol WaterReminderViewControllerDelegate: AnyObject {
    func handleCancel()
    func switchStatusChanged(selected: Bool)
}
class WaterReminderViewController: UIViewController {
    weak var delegate: WaterReminderViewControllerDelegate?
    var selectedH: Int = 0
    var selectedM: Int = 0
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var switchButton: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = UserDefaults.standard.bool(forKey: "switchButtonStatus")
        switchControl.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.text = "How often would you like us to remind you?"
        label.font = FontHelper.customFont(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.countDownDuration = 900
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy var silenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Notifications are silenced between 22:00 - 09:00 every day."
        label.font = FontHelper.customFont(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var addButton: UIButton = {
        let tintColor = #colorLiteral(red: 0.0004648703907, green: 0.5735016465, blue: 0.9910971522, alpha: 1)
        let button = UIComponentsFactory.createCustomButton(title: "ADD", state: .normal, titleColor: tintColor, borderColor: tintColor, borderWidth: 2.0, cornerRadius: 12, clipsToBounds: true, action: handleAdd)
        button.titleLabel?.font = FontHelper.customFont(size: 12)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        checkForPermission()
        
    }
    @objc private func handleCancel() {
        
        delegate?.handleCancel()
        dismiss(animated: true)
    }
    @objc private func datePickerChanged(_ picker: UIDatePicker) {
        let totalValue = picker.countDownDuration
        let hour = Int(totalValue) / 3600
        let minute = (Int(totalValue) % 3600) / 60
        
        self.selectedH = hour
        self.selectedM = minute
    }
    @objc private func switchChanged() {
        
        if switchButton.isOn {
            self.addButton.isHidden = false
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UserDefaults.standard.setValue(switchButton.isOn, forKey: "switchButtonStatus")
            delegate?.switchStatusChanged(selected: switchButton.isOn)
            self.addButton.isHidden = true
        }
    }
    @objc private func handleAdd() {
        guard switchButton.isOn else { return }
        UserDefaults.standard.setValue(switchButton.isOn, forKey: "switchButtonStatus")
        delegate?.switchStatusChanged(selected: switchButton.isOn)
        
        if switchButton.isOn {
            dispatchNotification()
        }
        dismiss(animated: true)
        delegate?.handleCancel()
    }
}
extension WaterReminderViewController {
    func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .denied:
                return
            case .authorized:
                DispatchQueue.main.async {
                    if self.switchButton.isOn {
                        self.dispatchNotification()
                    }
                }
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        DispatchQueue.main.async {
                            if self.switchButton.isOn {
                                self.dispatchNotification()
                            }
                        }
                    }
                }
            default:
                return
            }
        }
    }
    func dispatchNotification() {
        let identifier = "water-reminder"
        let title = "Time to drink something"
        let body = "Let's have something to drink"
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let totalSeconds = (selectedH * 3600) + (selectedM * 60)
        guard totalSeconds >= 60 else { return }
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totalSeconds), repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}
extension WaterReminderViewController {
    private func setupLayout() {
        
        view.addSubview(containerView)
        containerView.addSubview(switchButton)
        containerView.addSubview(reminderLabel)
        containerView.addSubview(datePicker)
        containerView.addSubview(silenceLabel)
        view.addSubview(cancelButton)
        containerView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -86),
            
            cancelButton.centerYAnchor.constraint(equalTo: containerView.topAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 48),
            cancelButton.widthAnchor.constraint(equalToConstant: 48),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            switchButton.topAnchor.constraint(equalTo:containerView.topAnchor, constant: 12),
            switchButton.heightAnchor.constraint(equalToConstant: 32),
            switchButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/7),
            switchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            reminderLabel.topAnchor.constraint(equalTo: switchButton.bottomAnchor,constant: 12),
            reminderLabel.heightAnchor.constraint(equalToConstant: 32),
            reminderLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            reminderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            
            datePicker.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 12),
            datePicker.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            datePicker.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            datePicker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            silenceLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 12),
            silenceLabel.heightAnchor.constraint(equalToConstant: 24),
            silenceLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            silenceLabel.leadingAnchor.constraint(equalTo: reminderLabel.leadingAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            addButton.heightAnchor.constraint(equalToConstant: 36),
            addButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4),
            addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
}
