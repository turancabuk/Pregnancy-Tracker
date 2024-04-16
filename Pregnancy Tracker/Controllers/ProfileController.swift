//
//  ProfileController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit
import JGProgressHUD

class ProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var defaults = UserDefaults.standard
    let hud = JGProgressHUD(style: .dark)
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "ffbc42")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 60 / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let imageData = defaults.data(forKey: "profileImage") {
            imageView.image = UIImage(data: imageData)
        }else{
            imageView.image = UIImage(named: "women")
        }
        return imageView
    }()

    lazy var changeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "change")
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleChange)))
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameTextfield: UITextField = {
        let name = defaults.value(forKey: "userName")
        let textfield = UIComponentsFactory.createCustomTextfield(placeHolder: "\(name ?? "enter your name")", fontSize: 16, borderColor: UIColor.white, borderWidth: 3.0, cornerRadius: 12)
        textfield.backgroundColor = UIColor.orange
        textfield.textColor = UIColor.black
        textfield.paddingLeft(padding: 12)
        textfield.textAlignment = .center
        return textfield
    }()

    lazy var datePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Select your last Menstrual Period"
        label.font = FontHelper.customFont(size: 16)
        label.textColor = UIColor.black
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
        datePicker.backgroundColor = UIColor(hex: "ffbc42")
        datePicker.layer.cornerRadius = 16
        datePicker.clipsToBounds = true
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: UIColor.orange, borderColor: .white, borderWidth: 2.0, cornerRadius: 12, clipsToBounds: true, action: handleSave)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        
        
    }
    @objc func handleChange() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        hud.textLabel.text = "select a photo"
        hud.show(in: view)
        present(imagePicker, animated: true)
        hud.dismiss()
    }
    func updateProfilePhoto() {
        DispatchQueue.main.async {
            if let imageData = self.defaults.data(forKey: "profileImage") {
                self.profileImageView.image = UIImage(data: imageData)
            }else{
                self.profileImageView.image = UIImage(named: "women")
            }
            self.nameTextfield.text = self.defaults.string(forKey: "userName") ?? "Enter your name"
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    @objc func handleSave() {
        
        let profileManager = ProfileManager()
        profileManager.userDefaultsProfileManager(from: self, nameTextfield: nameTextfield, profileImageView: profileImageView, datePicker: datePicker)
        
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }

    }
    @objc fileprivate func handleDismiss(){
        view.endEditing(true)
    }
    @objc fileprivate func handleDatePicker() {
        print("date selected")
    }
}
extension ProfileController {
    private func setupLayout() {
        
        view.addSubview(topView)
        view.addSubview(seperatorView)
        view.addSubview(bottomView)
        view.addSubview(profileImageView)
        view.addSubview(changeImageView)
        view.addSubview(nameTextfield)
        view.addSubview(datePickerLabel)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6.5),
            
            seperatorView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 2),
            
            bottomView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileImageView.centerXAnchor.constraint(equalTo: seperatorView.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: seperatorView.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2.5/6),
            
            changeImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -4),
            changeImageView.widthAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1/7),
            changeImageView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -6),
            changeImageView.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1/7),
            
            nameTextfield.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            nameTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            nameTextfield.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            nameTextfield.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/25),
            
            datePickerLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 24),
            datePickerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            datePickerLabel.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor),
            datePickerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30),
            
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 12),
            datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/10),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -12),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 160),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
