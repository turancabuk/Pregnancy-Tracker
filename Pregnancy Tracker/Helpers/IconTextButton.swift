//
//  IconTextButton.swift
//  Pregnancy Tracker
//
//  Created by Hüseyin HÖBEK on 14.03.2024.
//

import UIKit

class IconTextButton: UIButton {
    private let iconImageView = UIImageView()
    private let customTitleLabel = UILabel()

    init(icon: UIImage?, title: String) {
        super.init(frame: .zero)
        
        iconImageView.image = icon
        customTitleLabel.text = title
        
        addSubview(iconImageView)
        addSubview(customTitleLabel)
        
        customTitleLabel.textColor = .black
        customTitleLabel.font = FontHelper.customFont(size: 18)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        customTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24), // İkon boyutu
            iconImageView.heightAnchor.constraint(equalToConstant: 24), // İkon boyutu
            
            customTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            customTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            customTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
