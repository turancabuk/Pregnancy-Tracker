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
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var dateTimeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
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
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    fileprivate func setupLayout(){
        
        addSubview(containerView)
        containerView.addSubview(dateTimeContainerView)
        dateTimeContainerView.addSubview(dateLabel)
        dateTimeContainerView.addSubview(timeLabel)
        containerView.addSubview(aboutLabel)
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.black.cgColor
        
        
        containerView.fillSuperview()
        
        NSLayoutConstraint.activate([
            dateTimeContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            dateTimeContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            dateTimeContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            dateTimeContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),
            dateTimeContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateTimeContainerView.leadingAnchor, constant: 12),
            dateLabel.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 1/2),
            dateLabel.bottomAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: dateTimeContainerView.trailingAnchor, constant: -12),
            timeLabel.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 1/2),
            timeLabel.bottomAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor, constant: 4),
            aboutLabel.leadingAnchor.constraint(equalTo: dateTimeContainerView.leadingAnchor),
            aboutLabel.trailingAnchor.constraint(equalTo: dateTimeContainerView.trailingAnchor),
            aboutLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2/3)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
