//
//  VerticalCollectionViewCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 17.03.2024.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    let imageView = UIImageView()
    let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(infoLabel)
        
        containerView.backgroundColor = .white
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3),
            
            infoLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            infoLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        ShadowLayer.setShadow(view: imageView, color: .darkGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 5)
        ShadowLayer.setShadow(view: containerView, color: .darkGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
