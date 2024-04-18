//
//  DietView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 18.04.2024.
//

import UIKit

class DietView: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "diet")
        view.backgroundColor = .red
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dietLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupUI()
        
    }
    fileprivate func setupLayout(){
        
        view.backgroundColor = .red
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dietLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/4),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 52),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            dietLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dietLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dietLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dietLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    fileprivate func setupUI() {
        let dietDescription = DietAndFoodInfoProvider.shared.getDietDescription(for: .diet)
        self.dietLabel.text = dietDescription
    }
}
