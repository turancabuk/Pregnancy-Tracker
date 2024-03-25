//
//  SettingsController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class SettingsController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCustomViews()
    }
    
    func setupCustomViews() {
        let items = [
                ("shareIcon", "Bizi Paylaşın", #selector(shareTapped)),
                ("rateIcon", "Bizi Oylayın", #selector(rateTapped)),
                ("contactIcon", "Bize Ulaşın", #selector(contactTapped)),
                ("privacyIcon", "Gizlilik İlkesi", #selector(privacyTapped))
            ]
        
        var previousBottomAnchor = view.safeAreaLayoutGuide.topAnchor
        
        for (index, (iconName, title, selector)) in items.enumerated() {
            let iconView = createCustomViewWith(iconName: iconName, title: title)
            view.addSubview(iconView)
            
            // UITapGestureRecognizer ekleniyor
            let tapGesture = UITapGestureRecognizer(target: self, action: selector)
            iconView.addGestureRecognizer(tapGesture)
            iconView.isUserInteractionEnabled = true // Bu önemli, varsayılan olarak false
            
            iconView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                iconView.topAnchor.constraint(equalTo: previousBottomAnchor, constant: index == 0 ? 220 : 36), // İlk eleman için 20, diğerleri için 36 birim boşluk
                iconView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                iconView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                iconView.heightAnchor.constraint(equalToConstant: 50) // Her bir view'in yüksekliği
            ])
            
            previousBottomAnchor = iconView.bottomAnchor
        }
    }
    
    func createCustomViewWith(iconName: String, title: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(hex: "DDBEA8")
        container.layer.cornerRadius = 12
        container.clipsToBounds = true
        let imageView = UIImageView(image: UIImage(named: iconName))
        imageView.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = FontHelper.customFont(size: 24)
        
        container.addSubview(imageView)
        container.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor), // ImageView'ın sağ tarafından başlayarak
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -24), // Container'ın sağ tarafına uygun bir boşluk bırakarak
            label.widthAnchor.constraint(lessThanOrEqualTo: container.widthAnchor, multiplier: 3/4) // Label genişliği container'ın 3/4'ü kadar
        ])
        
        
        return container
    }
    
    @objc func shareTapped() {
            print("Share tapped")
        }

        @objc func rateTapped() {
            print("Rate tapped")
        }

        @objc func contactTapped() {
            print("Contact tapped")
        }

        @objc func privacyTapped() {
            print("Privacy tapped")
        }
    
}
