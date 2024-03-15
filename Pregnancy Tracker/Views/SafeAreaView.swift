//
//  SafeAreaView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import UIKit

class SafeAreaView: UIView {
    
    let defaults = UserDefaults.standard
    
    lazy var safeAreaView: UIView = {
        let safeAreaView = UIView()
        safeAreaView.frame = CGRect(x: 24, y: 50, width: frame.width - 24 * 2 , height: frame.height - 50 * 2)
        safeAreaView.backgroundColor = .white
        safeAreaView.layer.cornerRadius = 16
        safeAreaView.clipsToBounds = true
        safeAreaView.backgroundColor = .orange
        return safeAreaView
    }()
    lazy var personelView: UIView = {
        personelView = UIView()
        personelView.layer.cornerRadius = 12
        personelView.clipsToBounds = true
        return personelView
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
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        let defaults = UserDefaults.standard
        label.text = defaults.string(forKey: "userName") ?? ""
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        return label
    }()
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    lazy var weightValueLabel: UILabel = {
        let label = UILabel()
        let kgValue = defaults.string(forKey: "kgValue") ?? ""
        let gValue = defaults.string(forKey: "gValue") ?? ""
        label.text = "\(kgValue).\(gValue) kg"
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        return label
    }()
    lazy var pregnancyWeekLabel: UILabel = {
        let label = UILabel()
        label.text = "Pregnancy Week"
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    lazy var pregnancyWeekValue: UILabel = {
        let label = UILabel()
        if let savedData = defaults.data(forKey: "pregnancyDate"),
           let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Date {
            
            let today = Date()
            let calendar = Calendar.current
            let difference = calendar.dateComponents([.weekOfYear], from: savedDate, to: today)
            
            if let weeks = difference.weekOfYear {
                label.text = "\(weeks + 1). week"
            }else{
                label.text = "Unknowned"
            }
        }else{
            label.text = "hesaplanamadı"
        }
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        return label
    }()
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    lazy var heightValueLabel: UILabel = {
        let label = UILabel()
        let mValue = defaults.string(forKey: "mValue") ?? ""
        let cmValue = defaults.string(forKey: "cmValue") ?? ""
        label.text = "\(mValue).\(cmValue)cm"
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        return label
    }()
    lazy var birthDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birth Day"
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    lazy var birthDayValue: UILabel = {
        let label = UILabel()
        if let savedDateData = UserDefaults.standard.data(forKey: "pregnancyDate"),
           let savedDate = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedDateData) as? Date {

            let calendar = Calendar.current
            var components = DateComponents()
            components.month = 9
            components.day = 10
            if let futureDate = calendar.date(byAdding: components, to: savedDate) {

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let futureDateString = dateFormatter.string(from: futureDate)
                
                label.text = "\(futureDateString)❤️"
            } else {
                label.text = "Pregnancy Date?"
            }
        } else {
            label.text = "Pregnancy Date?"
        }
        label.font = FontHelper.customFont(size: 16)
        label.textAlignment = .center
        label.textColor = .systemPink
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    func setupView() {

        addSubview(safeAreaView)
        addSubview(personelView)
        personelView.addSubview(profileImageView)
        personelView.addSubview(nameLabel)
        personelView.addSubview(weightLabel)
        personelView.addSubview(weightValueLabel)
        personelView.addSubview(pregnancyWeekLabel)
        personelView.addSubview(pregnancyWeekValue)
        personelView.addSubview(heightLabel)
        personelView.addSubview(heightValueLabel)
        personelView.addSubview(birthDayLabel)
        personelView.addSubview(birthDayValue)

        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        personelView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        pregnancyWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        pregnancyWeekValue.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthDayValue.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            safeAreaView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            safeAreaView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            safeAreaView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            personelView.topAnchor.constraint(equalTo: safeAreaView.topAnchor),
            personelView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            personelView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            personelView.heightAnchor.constraint(equalTo: safeAreaView.heightAnchor, multiplier: 1/3),
            
            profileImageView.topAnchor.constraint(equalTo: personelView.topAnchor, constant: 40),
            profileImageView.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/3),
            profileImageView.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/4),
            profileImageView.centerXAnchor.constraint(equalTo: personelView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            nameLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            nameLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            nameLabel.centerXAnchor.constraint(equalTo: personelView.centerXAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: personelView.topAnchor, constant: 20),
            weightLabel.leadingAnchor.constraint(equalTo: personelView.leadingAnchor, constant: 6),
            weightLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            weightLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            weightValueLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: -12),
            weightValueLabel.leadingAnchor.constraint(equalTo: personelView.leadingAnchor, constant: 6),
            weightValueLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            weightValueLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            heightLabel.topAnchor.constraint(equalTo: personelView.topAnchor, constant: 20),
            heightLabel.trailingAnchor.constraint(equalTo: personelView.trailingAnchor, constant: -6),
            heightLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            heightLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            heightValueLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: -12),
            heightValueLabel.trailingAnchor.constraint(equalTo: personelView.trailingAnchor, constant: -6),
            heightValueLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            heightValueLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            pregnancyWeekValue.bottomAnchor.constraint(equalTo: personelView.bottomAnchor, constant: 6),
            pregnancyWeekValue.leadingAnchor.constraint(equalTo: weightLabel.leadingAnchor),
            pregnancyWeekValue.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            pregnancyWeekValue.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/2),
            
            pregnancyWeekLabel.bottomAnchor.constraint(equalTo: pregnancyWeekValue.topAnchor, constant: 12),
            pregnancyWeekLabel.leadingAnchor.constraint(equalTo: weightLabel.leadingAnchor),
            pregnancyWeekLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            pregnancyWeekLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/2),
            
            birthDayValue.bottomAnchor.constraint(equalTo: personelView.bottomAnchor, constant: 6),
            birthDayValue.trailingAnchor.constraint(equalTo: heightLabel.trailingAnchor),
            birthDayValue.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            birthDayValue.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/2),
            
            birthDayLabel.bottomAnchor.constraint(equalTo: birthDayValue.topAnchor, constant: 12),
            birthDayLabel.trailingAnchor.constraint(equalTo: heightLabel.trailingAnchor),
            birthDayLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            birthDayLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/2)
        ])
    }
    func setPersonelView(backgroundColor: UIColor) {
        personelView.backgroundColor = backgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
