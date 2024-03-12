//
//  PersonalInformationView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 10.03.2024.
//

import UIKit

class PersonalInformationView: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    let personalCardColor = #colorLiteral(red: 0.970778048, green: 0.8382893801, blue: 0.8796723485, alpha: 1)
    let personalCardColor1 = #colorLiteral(red: 0.9507680535, green: 0.7077944875, blue: 0.8335040212, alpha: 1)
    var pickerNumbers = Array(0...42)
    var picker1Numbers = Array(0...6)
    let profileImageView = UIImageView()
    let nameTextfield = PaddedPlaceHolder()
    let datePicker = UIDatePicker()
    var picker = UIPickerView()
    var picker1 = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    fileprivate func setupView() {
        view.backgroundColor = personalCardColor
        let safeAreaView = UIView()
        view.addSubview(safeAreaView)
        
        safeAreaView.anchor(
            top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(
                top: 50, left: 24, bottom: 10, right: 24))
        
        safeAreaView.backgroundColor = personalCardColor1
        safeAreaView.layer.cornerRadius = 16
        safeAreaView.clipsToBounds = true
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.tintColor = .white
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePicker)))
        
        safeAreaView.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor).isActive = true
        
        profileImageView.anchor(
            top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(
                top: 80, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 80))
        
        let nameDesLabel = UILabel()
        nameDesLabel.text = "Select a photo"
        nameDesLabel.font = FontHelper.customFont(size: 15)
        nameDesLabel.textColor = .black
        nameDesLabel.textAlignment = .center
        
        safeAreaView.addSubview(nameDesLabel)
        nameDesLabel.anchor(
            top: profileImageView.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: safeAreaView.trailingAnchor, padding: .init(
                top: 4, left: 60, bottom: 0, right: 60), size: .init(width: 120, height: 40))
        
        nameTextfield.placeHolderPadding = 18
        nameTextfield.font = FontHelper.customFont(size: 18)
        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        nameTextfield.layer.borderColor = UIColor.white.cgColor
        nameTextfield.layer.borderWidth = 2.0
        nameTextfield.borderStyle = .line
        nameTextfield.layer.cornerRadius = 8
        nameTextfield.clipsToBounds = true
        nameTextfield.placeholder = "Enter your name"
        nameTextfield.tintColor = .black
        nameTextfield.textColor = .purple
        nameTextfield.textAlignment = .left
        
        safeAreaView.addSubview(nameTextfield)
        nameTextfield.anchor(
            top: nameDesLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: safeAreaView.trailingAnchor, padding: .init(
                top: 36, left: 12, bottom: 0, right: 60), size: .init(width: safeAreaView.frame.width, height: 30))
        
        let dateLabel = UILabel()
        dateLabel.text = "Select your Last Menstrual Period"
        dateLabel.font = FontHelper.customFont(size: 14)
        dateLabel.textColor = .purple
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        safeAreaView.addSubview(dateLabel)
        dateLabel.anchor(
            top: nameTextfield.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 48, left: 30, bottom: 0, right: 0), size: .init(width: 280, height: 36))

        let datePickerContainer = UIView()
        datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.addSubview(datePickerContainer)
        datePickerContainer.anchor(
            top: dateLabel.bottomAnchor, leading: dateLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 6, left: 0, bottom: 0, right: 0), size: .init(width: 180, height: 40))
        
        datePicker.isUserInteractionEnabled = true
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let currentDate = Date()
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)
        datePicker.maximumDate = currentDate
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        datePickerContainer.addSubview(datePicker)

        
        let pregnancyWeekLabel = UILabel()
        pregnancyWeekLabel.text = "or Select your Pregnancy Week"
        pregnancyWeekLabel.font = FontHelper.customFont(size: 14)
        pregnancyWeekLabel.textColor = .purple
        
        safeAreaView.addSubview(pregnancyWeekLabel)
        pregnancyWeekLabel.anchor(
            top: datePickerContainer.bottomAnchor, leading: datePickerContainer.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 36, left: 0, bottom: 0, right: 0), size: .init(width: 280, height: 40))
        
        picker.backgroundColor = .clear
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.delegate = self
        picker.dataSource = self
        
        safeAreaView.addSubview(picker)
        picker.anchor(
            top: pregnancyWeekLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 0, left: 4, bottom: 0, right: 0), size: .init(width: 180, height: 100))
        
        picker1.backgroundColor = .clear
        picker1.setValue(UIColor.black, forKey: "textColor")
        picker1.delegate = self
        picker1.dataSource = self
        
        safeAreaView.addSubview(picker1)
        picker1.anchor(
            top: pregnancyWeekLabel.bottomAnchor, leading: picker.trailingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 0, left: 4, bottom: 0, right: 0), size: .init(width: 180, height: 100))
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.borderColor = personalCardColor.cgColor
        saveButton.layer.borderWidth = 3.0
        saveButton.layer.cornerRadius = 16
        saveButton.clipsToBounds = true
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        
        safeAreaView.addSubview(saveButton)
        saveButton.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor).isActive = true
        saveButton.anchor(
            top: nil, leading: nil, bottom: safeAreaView.bottomAnchor, trailing: nil, padding: .init(
                top: 0, left: 40, bottom: 26, right: 40), size: .init(width: 160, height: 40))
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.picker {
            return String(pickerNumbers[row])
        }else{
            return String(picker1Numbers[row])
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker {
            return pickerNumbers.count
        }else{
            return picker1Numbers.count
        }
    }
    @objc fileprivate func handlePicker() {
        print("select a photo")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    @objc fileprivate func handleDatePicker() {
        print("select a date")
    }
    @objc fileprivate func handleSave() {
        guard let name = nameTextfield.text, !name.isEmpty else {
            self.showAlert(message: "please enter your name")
            return
        }
        guard let profileImage = profileImageView.image, profileImage != UIImage(systemName: "person.crop.circle.badge.plus") else {
            self.showAlert(message: "Please select a profile image")
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.setValue(name, forKey: "userName")
        defaults.setValue(pickerNumbers[picker.selectedRow(inComponent: 0)], forKey: "weekValue")
        defaults.setValue(picker1Numbers[picker1.selectedRow(inComponent: 0)], forKey: "weekValue")
        let selectedDate = datePicker.date
        defaults.setValue(selectedDate, forKey: "lastMenstrualPeriod")
        if let imageData = profileImage.jpegData(compressionQuality: 1.0) {
            defaults.set(imageData, forKey: "profileImage")
        }else{
            showAlert(message: "please select a profile image")
        }
        defaults.synchronize()
        
        self.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = chosenImage
        }
        dismiss(animated: true, completion: nil)
    }
    fileprivate func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    @objc fileprivate func handleDismiss() {
        view.endEditing(true)
    }
}
