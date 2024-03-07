//
//  SafeAreaView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import UIKit

class SafeAreaView: UIView {
    
    var personelView: UIView!
    
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
        personelView.anchor(
            top: safeAreaView.topAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: safeAreaView.trailingAnchor, size: .init(width: 0, height: 280))
        
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .white
        personelView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 60 / 2
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = UIImage(named: "women")

        
        let centerYConstraint = profileImageView.centerYAnchor.constraint(equalTo: personelView.centerYAnchor, constant: -60)
        centerYConstraint.isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: personelView.centerXAnchor).isActive = true

        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let nameLabel = UILabel()
        personelView.addSubview(nameLabel)
        nameLabel.text = "Your Name"
        nameLabel.font = FontHelper.customFont(size: 16)
        nameLabel.textAlignment = .center
        
        nameLabel.centerXAnchor.constraint(equalTo: personelView.centerXAnchor).isActive = true
        nameLabel.anchor(
            top: profileImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(
                top: 12, left: 10, bottom: 0, right: 0), size: .init(
                    width: 200, height: 40))
        
        let weightLabel = UILabel()
        personelView.addSubview(weightLabel)
        weightLabel.text = "Weight"
        weightLabel.font = FontHelper.customFont(size: 16)
        weightLabel.textAlignment = .center
        
        weightLabel.anchor(
            top: nameLabel.bottomAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(
                top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        let weightValueLabel = UILabel()
        personelView.addSubview(weightValueLabel)
        weightValueLabel.text = "0.00 kg"
        weightValueLabel.font = FontHelper.customFont(size: 12)
        weightValueLabel.textAlignment = .center
        
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
                top: 4, left: 0, bottom: 0, right: 0), size: .init(width: 120, height: 28))
        
        let heightValueLabel = UILabel()
        personelView.addSubview(heightValueLabel)
        heightValueLabel.text = "0.00 cm"
        heightValueLabel.font = FontHelper.customFont(size: 12)
        heightValueLabel.textAlignment = .center
        
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
