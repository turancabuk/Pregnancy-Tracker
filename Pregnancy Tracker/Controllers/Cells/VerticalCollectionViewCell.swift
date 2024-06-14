//
//  VerticalCollectionViewCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 17.03.2024.
//

import UIKit

class VerticalCollectionViewCell: UICollectionViewCell {
    
    let containerLayerView = UIView()
    let containerView = UIView()
    let imageView = UIImageView()
    let imageContainerView = UIView()
    let infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerLayerView)
        containerLayerView.addSubview(containerView)
        containerView.addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        containerView.addSubview(infoLabel)
        
        containerLayerView.fillSuperview()
        
        containerView.backgroundColor = .white
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        
        containerLayerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: containerLayerView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: containerLayerView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: containerLayerView.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: containerLayerView.trailingAnchor),
            
            imageContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            imageContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            imageContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            imageContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3),
            
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 2),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant:  -8),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -2),
            
            infoLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            infoLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            infoLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        ShadowLayer.setShadow(view: containerLayerView, color: .darkGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 3)
        ShadowLayer.setShadow(view: imageContainerView, color: .lightGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
