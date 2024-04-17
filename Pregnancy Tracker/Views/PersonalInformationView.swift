//
//  PersonalInformationView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 10.03.2024.
//

import UIKit
import JGProgressHUD

class PersonalInformationView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let defaults = UserDefaults.standard
    let personalCardColor = #colorLiteral(red: 0.970778048, green: 0.8382893801, blue: 0.8796723485, alpha: 1)
    let personalCardColor1 = #colorLiteral(red: 0.9507680535, green: 0.7077944875, blue: 0.8335040212, alpha: 1)
    let hud = JGProgressHUD(style: .dark)
    
    lazy var safeAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = personalCardColor1
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePicker)))
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var photoDesLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a photo"
        label.textColor = .black
        label.font = FontHelper.customFont(size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextfield: UITextField = {
        let textfield = UIComponentsFactory.createCustomTextfield(placeHolder: "Enter your name", fontSize: 18, borderColor: UIColor.white, borderWidth: 2.0, cornerRadius: 8)
        textfield.paddingLeft(padding: 18)
        return textfield
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Select your last Menstrual Period"
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let currentDate = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)
        datePicker.maximumDate = currentDate
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.layer.cornerRadius = 16
        datePicker.clipsToBounds = true
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    
    lazy var saveButton = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: .white, borderColor: personalCardColor, borderWidth: 3.0, cornerRadius: 16, clipsToBounds: true, action: handleSave)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)

    }
    
    // MARK: Button Confgs.
    @objc fileprivate func handlePicker() {
        hud.textLabel.text = "select a photo"
        hud.show(in: view)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = chosenImage
        }
        dismiss(animated: true) {
            self.hud.dismiss()
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            self.hud.dismiss()
        }
    }
    @objc fileprivate func handleDatePicker() {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: selectedDate)
        print("select a date\(dateString)")
    }
    @objc fileprivate func handleSave() {
        
        let profilerManager = ProfileManager()
        profilerManager.userDefaultsProfileManager(from: self, nameTextfield: nameTextfield, profileImageView: profileImageView, datePicker: datePicker)
        
        self.dismiss(animated: true)
    }
    @objc fileprivate func handleDismiss() {
        view.endEditing(true)
    }
}
extension PersonalInformationView {
    fileprivate func setupView() {
        
        view.backgroundColor = personalCardColor
        datePicker.backgroundColor = personalCardColor
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(profileImageView)
        safeAreaView.addSubview(photoDesLabel)
        safeAreaView.addSubview(nameTextfield)
        safeAreaView.addSubview(dateLabel)
        view.addSubview(datePicker)
        safeAreaView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeAreaView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -24),
            safeAreaView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            profileImageView.topAnchor.constraint(equalTo: safeAreaView.topAnchor, constant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),
            
            photoDesLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            photoDesLabel.heightAnchor.constraint(equalToConstant: 40),
            photoDesLabel.widthAnchor.constraint(equalToConstant: 120),
            photoDesLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            nameTextfield.topAnchor.constraint(equalTo: photoDesLabel.bottomAnchor, constant: 24),
            nameTextfield.heightAnchor.constraint(equalToConstant: 30),
            nameTextfield.widthAnchor.constraint(equalTo: safeAreaView.widthAnchor, multiplier: 2/3),
            nameTextfield.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 36),
            dateLabel.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: nameTextfield.widthAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 36),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            datePicker.widthAnchor.constraint(equalTo: safeAreaView.widthAnchor, constant: -24),
            datePicker.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            datePicker.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24),
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 160),
            saveButton.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
        ])
    }
}
