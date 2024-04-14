//
//  PersonalInformationView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 10.03.2024.
//

import UIKit
import JGProgressHUD

class PersonalInformationView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let personalCardColor = #colorLiteral(red: 0.970778048, green: 0.8382893801, blue: 0.8796723485, alpha: 1)
    let personalCardColor1 = #colorLiteral(red: 0.9507680535, green: 0.7077944875, blue: 0.8335040212, alpha: 1)
    var pickerNumbers = Array(0...120)
    var picker1Numbers = Array(0...99)
    var picker2Numbers = Array(0...2)
    var picker3Numbers = Array(0...99)
    let profileImageView = UIImageView()
    let nameTextfield = PaddedPlaceHolder()
    let datePicker = UIDatePicker()
    var picker = UIPickerView()
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()
    var picker3 = UIPickerView()
    let hud = JGProgressHUD(style: .dark)
    lazy var saveButton = UIComponentsFactory.createCustomButton(title: "SAVE", state: .normal, titleColor: .white, borderColor: personalCardColor, borderWidth: 3.0, cornerRadius: 16, clipsToBounds: true, action: handleSave)
    
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
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        safeAreaView.addSubview(scrollView)

        // Set scrollView constraints
        scrollView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaView.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor).isActive = true

        // Add a contentView to the scrollView
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        scrollView.addSubview(contentView)

        // Set contentView constraints
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        // ImageView constraints
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.tintColor = .white
        profileImageView.layer.cornerRadius = 16
        profileImageView.clipsToBounds = true
        profileImageView.isUserInteractionEnabled = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePicker)))
        
        contentView.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        profileImageView.anchor(
            top: contentView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(
                top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 80))

        let photoDesLabel = createPersonalLabel(text: "Select a photo", textColor: .black)
        photoDesLabel.textAlignment = .center
        contentView.addSubview(photoDesLabel)
        
        photoDesLabel.anchor(
            top: profileImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(
                top: 4, left: 60, bottom: 0, right: 60), size: .init(width: 120, height: 40))
        
        // Textfield constraints
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
        
        contentView.addSubview(nameTextfield)
        nameTextfield.anchor(
            top: photoDesLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(
                top: 36, left: 12, bottom: 0, right: 10), size: .init(width: contentView.frame.width, height: 30))
        
        let dateLabel = createPersonalLabel(text: "Select your last Menstrual Period", textColor: .purple)
        contentView.addSubview(dateLabel)
        
        dateLabel.anchor(
            top: nameTextfield.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 36, left: 30, bottom: 0, right: 0), size: .init(width: 280, height: 36))

        // UIPicker constraints
        let datePickerContainer = UIView()
        datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(datePickerContainer)
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

        let weightLabel = createPersonalLabel(text: "Your Weight", textColor: .purple)
        contentView.addSubview(weightLabel)
        
        weightLabel.anchor(
            top: datePickerContainer.bottomAnchor, leading: datePickerContainer.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 36, left: 0, bottom: 0, right: 0), size: .init(width: 280, height: 40))
        
        customPicker(picker: picker)
        customPicker(picker: picker1)
        
        let weightPickerStack = createPickerStackView(withPickers: [picker, picker1])
        contentView.addSubview(weightPickerStack)
        weightPickerStack.anchor(
            top: weightLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: 0, height: 150))
        
        let heightLabel = createPersonalLabel(text: "Your HEight", textColor: .purple)
        contentView.addSubview(heightLabel)
        
        heightLabel.anchor(
            top: weightPickerStack.bottomAnchor, leading: weightLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 36, left: 0, bottom: 0, right: 0), size: .init(width: 280, height: 40))
        
        customPicker(picker: picker2)
        customPicker(picker: picker3)
  
        let heightPickerStack = createPickerStackView(withPickers: [picker2, picker3])
        contentView.addSubview(heightPickerStack)
        heightPickerStack.anchor(
            top: heightLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: 0, height: 150))
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(saveButton)
        saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        saveButton.anchor(
            top: heightPickerStack.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(
                top: 40, left: 40, bottom: 26, right: 40), size: .init(width: 160, height: 40))

        let endBottom = saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        endBottom.isActive = true
        endBottom.priority = UILayoutPriority(999)
    }
    fileprivate func createPickerStackView(withPickers pickers: [UIPickerView]) -> UIStackView {
        let pickerStackView = UIStackView(arrangedSubviews: pickers)
        pickerStackView.distribution = .fillEqually
        pickerStackView.axis = .horizontal
        pickerStackView.spacing = 8
        pickerStackView.translatesAutoresizingMaskIntoConstraints = false
        return pickerStackView
    }
    fileprivate func createPersonalLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = FontHelper.customFont(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    // MARK: Button Confgs.
    @objc fileprivate func handlePicker() {
        print("select a photo")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        hud.textLabel.text = "select a photo"
        hud.show(in: view)
        present(picker, animated: true)
        hud.dismiss()
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
        defaults.setValue(pickerNumbers[picker.selectedRow(inComponent: 0)], forKey: "kgValue")
        defaults.setValue(picker1Numbers[picker1.selectedRow(inComponent: 0)], forKey: "gValue")
        defaults.setValue(picker2Numbers[picker2.selectedRow(inComponent: 0)], forKey: "mValue")
        defaults.setValue(picker3Numbers[picker3.selectedRow(inComponent: 0)], forKey: "cmValue")
        defaults.set(try? NSKeyedArchiver.archivedData(withRootObject: datePicker.date, requiringSecureCoding: false), forKey: "pregnancyDate")
        
        if let imageData = profileImage.jpegData(compressionQuality: 1.0) {
            defaults.set(imageData, forKey: "profileImage")
        }else{
            showAlert(message: "please select a profile image")
        }
        defaults.synchronize() 
        
        self.dismiss(animated: true)
    }
    @objc fileprivate func handleDismiss() {
        view.endEditing(true)
    }
}
extension PersonalInformationView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case picker:
            return String(pickerNumbers[row])
        case picker1:
            return String(picker1Numbers[row])
        case picker2:
            return String(picker2Numbers[row])
        case picker3:
            return String(picker3Numbers[row])
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case picker:
            return pickerNumbers.count
        case picker1:
            return picker1Numbers.count
        case picker2:
            return picker2Numbers.count
        case picker3:
            return picker3Numbers.count
        default:
            return 0
        }
    }
    func customPicker(picker: UIPickerView) {
        picker.frame = CGRect(x: 0, y: 0, width: 60, height: 100)
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .clear
        picker.setValue(UIColor.black, forKey: "textColor")
    }
}



