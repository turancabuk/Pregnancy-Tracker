//
//  CalendarCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 19.03.2024.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        ShadowLayer.setShadow(view: view, color: .lightGray, opacity: 0.4, offset: .init(width: 0.5, height: 0.5), radius: 4)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "alert")
        view.contentMode = .scaleAspectFill
         view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateTimeContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = FontHelper.customFont(size: 16)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = FontHelper.customFont(size: 12)
        return label
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "fcefef")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    fileprivate func setupLayout(){
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(dateTimeContainerView)
        dateTimeContainerView.addSubview(dateLabel)
        dateTimeContainerView.addSubview(timeLabel)
        containerView.addSubview(seperatorView)
        containerView.addSubview(aboutLabel)
        
        
        containerView.fillSuperview()
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/8),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            
            dateTimeContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            dateTimeContainerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            dateTimeContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            dateTimeContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),

            dateLabel.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateTimeContainerView.leadingAnchor, constant: 12),
            dateLabel.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 1/2),
            dateLabel.bottomAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: dateTimeContainerView.trailingAnchor),
            timeLabel.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 1/2),
            timeLabel.bottomAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            
            seperatorView.topAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 3/4),
            seperatorView.centerXAnchor.constraint(equalTo: dateTimeContainerView.centerXAnchor, constant: -12),
            seperatorView.bottomAnchor.constraint(equalTo: aboutLabel.topAnchor),
            
            
            aboutLabel.topAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor, constant: 4),
            aboutLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            aboutLabel.trailingAnchor.constraint(equalTo: dateTimeContainerView.trailingAnchor, constant: -4),
            aboutLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
