//
//  SafeAreaView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import UIKit

class SafeAreaView: UIView {
    
    var personelView: UIView!
    let defaults = UserDefaults.standard
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSafeAreaView()
    }
    func createSafeAreaView() {
        let safeAreaView = UIView()
        addSubview(safeAreaView)

        safeAreaView.frame = CGRect(x: 24, y: 50, width: frame.width - 24 * 2 , height: frame.height - 50 * 2)
        safeAreaView.backgroundColor = .white
        safeAreaView.layer.cornerRadius = 16
        safeAreaView.clipsToBounds = true
        
        personelView = UIView()
        addSubview(personelView)
        
        personelView.layer.cornerRadius = 12
        personelView.clipsToBounds = true
        personelView.heightAnchor.constraint(equalTo: safeAreaView.heightAnchor, multiplier: 1/3).isActive = true
        personelView.anchor(
            top: safeAreaView.topAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: safeAreaView.trailingAnchor)
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .white
        personelView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 60 / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        if let imageData = defaults.data(forKey: "profileImage") {
            profileImageView.image = UIImage(data: imageData)
        }else{
            profileImageView.image = UIImage(named: "women")
        }

        
        let centerYConstraint = profileImageView.centerYAnchor.constraint(equalTo: personelView.centerYAnchor, constant: -50)
        centerYConstraint.isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: personelView.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let nameLabel = UILabel()
        personelView.addSubview(nameLabel)
        let defaults = UserDefaults.standard
        nameLabel.text = defaults.string(forKey: "userName") ?? "your 4 name"
        nameLabel.font = FontHelper.customFont(size: 16)
        nameLabel.textAlignment = .center
        
        nameLabel.centerXAnchor.constraint(equalTo: personelView.centerXAnchor).isActive = true
        nameLabel.anchor(
            top: profileImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(
                top: 0, left: 10, bottom: 0, right: 0), size: .init(
                    width: 200, height: 40))
        
        let weightLabel = UILabel()
        personelView.addSubview(weightLabel)
        weightLabel.text = "Weight"
        weightLabel.font = FontHelper.customFont(size: 16)
        weightLabel.textAlignment = .center
        
        weightLabel.anchor(
            top: nameLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        let weightValueLabel = UILabel()
        personelView.addSubview(weightValueLabel)
        let kgValue = defaults.string(forKey: "kgValue") ?? ""
        let gValue = defaults.string(forKey: "gValue") ?? ""
        weightValueLabel.text = "\(kgValue).\(gValue) kg"
        weightValueLabel.font = FontHelper.customFont(size: 16)
        weightValueLabel.textAlignment = .center
        weightLabel.textColor = .white
        
        weightValueLabel.anchor(
            top: weightLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        let heightLabel = UILabel()
        personelView.addSubview(heightLabel)
        heightLabel.text = "Height"
        heightLabel.font = FontHelper.customFont(size: 16)
        heightLabel.textAlignment = .center
        
        heightLabel.anchor(
            top: nameLabel.bottomAnchor, leading: nil, bottom: nil, trailing: safeAreaView.trailingAnchor, padding: .init(
                top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        let heightValueLabel = UILabel()
        personelView.addSubview(heightValueLabel)
        let mValue = defaults.string(forKey: "mValue") ?? ""
        let cmValue = defaults.string(forKey: "cmValue") ?? ""
        heightValueLabel.text = "\(mValue).\(cmValue)cm"
        heightValueLabel.font = FontHelper.customFont(size: 16)
        heightValueLabel.textAlignment = .center
        heightLabel.textColor = .white
        
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
    
//    enum ColorOption {
//            case red, green, blue
//        }
//        
//        private var selectedColor: ColorOption?
//        
//        func selectColor(_ color: ColorOption) {
//            selectedColor = color
//            
//            switch color {
//            case .red:
//                backgroundColor = .red
//            case .green:
//                backgroundColor = .green
//            case .blue:
//                backgroundColor = .blue
//            }
//        }
}
