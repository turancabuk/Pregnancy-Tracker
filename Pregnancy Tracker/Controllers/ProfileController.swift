//
//  ProfileController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class ProfileController: UIViewController {
    
    var defaults = UserDefaults.standard
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "ffbc42")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 60 / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let imageData = defaults.data(forKey: "profileImage") {
            imageView.image = UIImage(data: imageData)
        }else{
            imageView.image = UIImage(named: "women")
        }
        return imageView
    }()

    lazy var changeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "change")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    private func setupLayout() {
        
        view.addSubview(topView)
        view.addSubview(seperatorView)
        view.addSubview(bottomView)
        view.addSubview(imageView)
        imageView.addSubview(changeImageView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            
            seperatorView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 2),
            
            bottomView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: seperatorView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: seperatorView.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/5),
            
            changeImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4),
            changeImageView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/5),
            changeImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -6),
            changeImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1/5)
        ])
    }
}
