//
//  MainCollectionViewCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 17.03.2024.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addSubview(imageView)
        imageView.fillSuperview()
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        containerView.layer.masksToBounds = false
        ShadowLayer.setShadow(view: containerView, color: .black, opacity: 1.0, offset: .init(width: 0.7, height: 0.7), radius: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
