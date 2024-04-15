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
    
    lazy var imageView: UIImageView = {
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameTextfield: UITextField = {
        let name = defaults.value(forKey: "userName")
        let textfield = UIComponentsFactory.createCustomTextfield(placeHolder: "\(name ?? "enter your name")", fontSize: 16, borderColor: UIColor.white, borderWidth: 3.0, cornerRadius: 12)
        textfield.backgroundColor = UIColor.orange
        textfield.textColor = UIColor.black
        textfield.translatesAutoresizingMaskIntoConstraints = false
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
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Height"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleChange))
        changeImageView.isUserInteractionEnabled = true
        changeImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    private func setupLayout() {
        
        view.addSubview(topView)
        view.addSubview(seperatorView)
        view.addSubview(bottomView)
        view.addSubview(imageView)
        view.addSubview(changeImageView)
        view.addSubview(nameTextfield)
        view.addSubview(datePickerLabel)
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            
            seperatorView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 2),
            
            bottomView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: seperatorView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: seperatorView.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2.5/6),
            
            changeImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4),
            changeImageView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/5),
            changeImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -6),
            changeImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1/5),
            
            nameTextfield.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            nameTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            nameTextfield.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nameTextfield.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/25),
            
            datePickerLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 24),
            datePickerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            datePickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            datePickerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/30),
            
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 12),
            datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4),
            datePicker.leadingAnchor.constraint(equalTo: datePickerLabel.leadingAnchor),
            datePicker.heightAnchor.constraint(equalTo: datePickerLabel.heightAnchor)
        ])
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
