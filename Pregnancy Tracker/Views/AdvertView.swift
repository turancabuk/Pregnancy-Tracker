//
//  AdvertView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 18.03.2024.
//

import UIKit

class AdvertView: UIView {
    
    let containerView = UIView()
    let imageView = UIImageView()
    let infoLabel = UILabel()
    let detailLabel = UILabel()
    let getButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(infoLabel)
        containerView.addSubview(detailLabel)
        containerView.addSubview(getButton)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        getButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .darkGray
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "littleSteps")
        
        infoLabel.text = "Little Steps Development"
        infoLabel.textColor = .white
        infoLabel.font = FontHelper.customFont(size: 12)
        
        detailLabel.text = "Child Development Tracker"
        detailLabel.textColor = .lightGray
        detailLabel.font = FontHelper.customFont(size: 12)
        
        getButton.setTitle("GET", for: .normal)
        getButton.setTitleColor(UIColor.link, for: .normal)
        getButton.addTarget(self, action: #selector(handleGetButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3),
            
            infoLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -46),
            infoLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),

            detailLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 4),
            detailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            detailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -46),
            detailLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),
            
            getButton.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor, constant: -12),
            getButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            getButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    @objc fileprivate func handleGetButton() {
        print("get button tapped")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
