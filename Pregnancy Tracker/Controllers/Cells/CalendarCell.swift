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
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    fileprivate func setupLayout(){
        
        addSubview(containerView)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(noteLabel)
        
        containerView.fillSuperview()
        
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            aboutLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),
            
            noteLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 4),
            noteLabel.leadingAnchor.constraint(equalTo: aboutLabel.leadingAnchor),
            noteLabel.trailingAnchor.constraint(equalTo: aboutLabel.trailingAnchor),
            noteLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2/3)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
