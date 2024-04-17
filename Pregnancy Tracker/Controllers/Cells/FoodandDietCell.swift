//
//  FoodandDietCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 17.04.2024.
//

import UIKit

class FoodandDietCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hex: "f79256")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageViewContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        
    }
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(imageViewContentView)
        imageViewContentView.addSubview(imageView)
        
        containerView.fillSuperview()
        imageView.fillSuperview()
        
        NSLayoutConstraint.activate([
            imageViewContentView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            imageViewContentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            imageViewContentView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -8),
            imageViewContentView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
