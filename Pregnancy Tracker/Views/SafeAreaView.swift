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
        personelView.addSubview(heightLabel)
        personelView.addSubview(heightValueLabel)

        personelView.heightAnchor.constraint(equalTo: safeAreaView.heightAnchor, multiplier: 1/3).isActive = true
        personelView.anchor(
            top: safeAreaView.topAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: safeAreaView.trailingAnchor)

        let centerYConstraint = profileImageView.centerYAnchor.constraint(equalTo: personelView.centerYAnchor, constant: -50)
        centerYConstraint.isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: personelView.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        nameLabel.centerXAnchor.constraint(equalTo: personelView.centerXAnchor).isActive = true
        nameLabel.anchor(
            top: profileImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(
                top: 0, left: 10, bottom: 0, right: 0), size: .init(
                    width: 200, height: 40))
        
        weightLabel.anchor(
            top: nameLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        

        weightValueLabel.anchor(
            top: weightLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        heightLabel.anchor(
            top: nameLabel.bottomAnchor, leading: nil, bottom: nil, trailing: safeAreaView.trailingAnchor, padding: .init(
                top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        
        heightValueLabel.anchor(
            top: heightLabel.bottomAnchor, leading: nil, bottom: nil, trailing: safeAreaView.trailingAnchor, padding: .init(
                top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))

    }
    func setPersonelView(backgroundColor: UIColor) {
        personelView.backgroundColor = backgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
