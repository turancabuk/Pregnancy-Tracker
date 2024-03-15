//
//  HomeCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.03.2024.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    var isSelectedState = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.layer.cornerRadius = 80 / 2
        imageView.clipsToBounds = true
        imageView.constrainWidth(constant: 80)
        imageView.constrainHeight(constant: 80)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func updateBorder(selected: Bool) {
//        isSelectedState = selected
//        imageView.layer.borderWidth = selected ? 2 : 0 // Seçili ise 2, değilse 0 genişlikte kenarlık
//        imageView.layer.borderColor = selected ? UIColor.blue.cgColor : UIColor.clear.cgColor
//        imageView.clipsToBounds = true
//    }
}
