//
//  SafeAreaView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import UIKit

class SafeAreaView: UIView {
    
    let defaults = UserDefaults.standard
    
    lazy var personelView: UIView = {
        personelView = UIView()
        personelView.layer.cornerRadius = 12
        personelView.clipsToBounds = true
        personelView.translatesAutoresizingMaskIntoConstraints = false
        return personelView
    }()
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 60 / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func createCustomLabel(fontSize: CGFloat, text: String? = nil, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = FontHelper.customFont(size: fontSize)
        label.textAlignment = .center
        label.text = text
        label.textColor = textColor
        return label
    }

    lazy var nameLabel = createCustomLabel(fontSize: 16, textColor: .black)
    lazy var pregnancyWeekLabel: UILabel = createCustomLabel(fontSize: 16, text: "Pregnancy Week", textColor: .white)
    lazy var pregnancyWeekValue = createCustomLabel(fontSize: 16, textColor: .black)
    lazy var birthDayLabel = createCustomLabel(fontSize: 16,text: "Birth Day", textColor: .white)
    lazy var birthDayValue = createCustomLabel(fontSize: 16, textColor: .systemPink)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    func setupView() {

        addSubview(personelView)
        personelView.addSubview(profileImageView)
        personelView.addSubview(nameLabel)
        personelView.addSubview(pregnancyWeekLabel)
        personelView.addSubview(pregnancyWeekValue)
        personelView.addSubview(birthDayLabel)
        personelView.addSubview(birthDayValue)

        personelView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        pregnancyWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        pregnancyWeekValue.translatesAutoresizingMaskIntoConstraints = false
        birthDayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDayValue.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            personelView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            personelView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            personelView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            personelView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/5.5),
            
            profileImageView.topAnchor.constraint(equalTo: personelView.topAnchor),
            profileImageView.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: personelView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            nameLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            nameLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            pregnancyWeekLabel.topAnchor.constraint(equalTo: personelView.bottomAnchor, constant: -60),
            pregnancyWeekLabel.leadingAnchor.constraint(equalTo: personelView.leadingAnchor, constant: 8),
            pregnancyWeekLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            pregnancyWeekLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            pregnancyWeekValue.topAnchor.constraint(equalTo: pregnancyWeekLabel.bottomAnchor),
            pregnancyWeekValue.leadingAnchor.constraint(equalTo: pregnancyWeekLabel.leadingAnchor),
            pregnancyWeekValue.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            pregnancyWeekValue.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            birthDayLabel.topAnchor.constraint(equalTo: personelView.bottomAnchor, constant: -60),
            birthDayLabel.trailingAnchor.constraint(equalTo: personelView.trailingAnchor),
            birthDayLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            birthDayLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            birthDayValue.topAnchor.constraint(equalTo: birthDayLabel.bottomAnchor),
            birthDayValue.trailingAnchor.constraint(equalTo: personelView.trailingAnchor),
            birthDayValue.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            birthDayValue.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
           
        ])
    }
    func updateUserInfo() {
        
        DispatchQueue.main.async {
            if let imageData = self.defaults.data(forKey: "profileImage") {
                self.profileImageView.image = UIImage(data: imageData)
            } else {
                self.profileImageView.image = UIImage(named: "women")
            }
            
            self.nameLabel.text = self.defaults.string(forKey: "userName") ?? "Unknown User"
            self.updatePregnancyWeek()
            self.updateBirthday()
        }
    }

    private func updatePregnancyWeek(){
        if let savedData = defaults.data(forKey: "pregnancyDate"),
           let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Date {
            let weeks = Calendar.current.dateComponents([.weekOfYear], from: savedDate, to: Date()).weekOfYear ?? 0
            pregnancyWeekValue.text = "\(weeks + 1) weeks"
        }
    }
    private func updateBirthday() {
        if let savedDateData = defaults.data(forKey: "pregnancyDate"),
           let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedDateData) as? Date {

            let calendar = Calendar.current
            var components = DateComponents()
            components.month = 9
            components.day = 10
            if let futureDate = calendar.date(byAdding: components, to: savedDate) {

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let futureDateString = dateFormatter.string(from: futureDate)
                
                birthDayValue.text = "\(futureDateString)❤️"
            } else {
                birthDayValue.text = "Pregnancy Date?"
            }
        } else {
            birthDayValue.text = "Pregnancy Date?"
        }
    }
    func setPersonelView(backgroundColor: UIColor) {
        personelView.backgroundColor = backgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
