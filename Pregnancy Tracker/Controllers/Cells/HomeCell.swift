//
//  HomeCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.03.2024.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 80)
        imageView.constrainHeight(constant: 80)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 180
        imageView.clipsToBounds = true
        ShadowLayer.setShadow(imageView: imageView, color: .darkGray, opacity: 0.7, offset: CGSize(width: 5, height: 5), radius: 5)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
