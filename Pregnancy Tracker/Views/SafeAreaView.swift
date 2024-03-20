//
//  SafeAreaView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import UIKit

class SafeAreaView: UIView {
    
    let defaults = UserDefaults.standard
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
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

        addSubview(personelView)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
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
            personelView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/6),
            
            profileImageView.topAnchor.constraint(equalTo: personelView.topAnchor, constant: 8),
            profileImageView.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 0.65/1),
            profileImageView.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/5),
            profileImageView.centerXAnchor.constraint(equalTo: personelView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            nameLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            nameLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            
            pregnancyWeekLabel.topAnchor.constraint(equalTo: personelView.topAnchor, constant: 12),
            pregnancyWeekLabel.leadingAnchor.constraint(equalTo: personelView.leadingAnchor, constant: 8),
            pregnancyWeekLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            pregnancyWeekLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            pregnancyWeekValue.topAnchor.constraint(equalTo: pregnancyWeekLabel.bottomAnchor),
            pregnancyWeekValue.leadingAnchor.constraint(equalTo: pregnancyWeekLabel.leadingAnchor),
            pregnancyWeekValue.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            pregnancyWeekValue.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            birthDayLabel.topAnchor.constraint(equalTo: personelView.topAnchor, constant: 12),
            birthDayLabel.trailingAnchor.constraint(equalTo: personelView.trailingAnchor),
            birthDayLabel.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            birthDayLabel.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
            
            birthDayValue.topAnchor.constraint(equalTo: birthDayLabel.bottomAnchor),
            birthDayValue.trailingAnchor.constraint(equalTo: personelView.trailingAnchor),
            birthDayValue.heightAnchor.constraint(equalTo: personelView.heightAnchor, multiplier: 1/5),
            birthDayValue.widthAnchor.constraint(equalTo: personelView.widthAnchor, multiplier: 1/3),
           
        ])
    }
    func setPersonelView(backgroundColor: UIColor) {
        personelView.backgroundColor = backgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
