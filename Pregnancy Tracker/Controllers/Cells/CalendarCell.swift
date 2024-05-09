//
//  CalendarCell.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 19.03.2024.
//

import UIKit
import CoreData

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
        label.textAlignment = .right
        label.textColor = .black
        label.font = FontHelper.customFont(size: 13)
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
    
    lazy var deleteButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "", state: .normal, titleColor: UIColor.clear, borderColor: UIColor.clear, borderWidth: 0.0, cornerRadius: 0.0, clipsToBounds: false, action: handleDelete)
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
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
    
    var onDeleteButtonTapped: (() -> Void)?
    
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
        addSubview(deleteButton)
        containerView.addSubview(seperatorView)
        containerView.addSubview(aboutLabel)
        containerView.fillSuperview()
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 112),
            imageView.widthAnchor.constraint(equalToConstant: 124),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            dateTimeContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            dateTimeContainerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            dateTimeContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            dateTimeContainerView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),

            dateLabel.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dateTimeContainerView.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 2/5),
            dateLabel.bottomAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            timeLabel.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 1/4),
            timeLabel.bottomAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: dateTimeContainerView.topAnchor, constant: -6),
            deleteButton.heightAnchor.constraint(equalToConstant: 48),
            deleteButton.widthAnchor.constraint(equalToConstant: 52),
            deleteButton.trailingAnchor.constraint(equalTo: dateTimeContainerView.trailingAnchor, constant: -2),

            seperatorView.topAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: dateTimeContainerView.widthAnchor, multiplier: 3/4),
            seperatorView.centerXAnchor.constraint(equalTo: dateTimeContainerView.centerXAnchor, constant: -24),
            seperatorView.heightAnchor.constraint(equalTo: dateTimeContainerView.heightAnchor, multiplier: 1/2),
            
            aboutLabel.topAnchor.constraint(equalTo: dateTimeContainerView.bottomAnchor, constant: 4),
            aboutLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            aboutLabel.trailingAnchor.constraint(equalTo: dateTimeContainerView.trailingAnchor, constant: -4),
            aboutLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    @objc fileprivate func handleDelete(){
        onDeleteButtonTapped?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CalendarCell {
    func configure(with data: NSManagedObject) {
        
    }
}
