//
//  AddWaterViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.05.2024.
//

import UIKit

class AddWaterViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func createCustomLabel(labelText: String, labelSize: CGFloat) -> UILabel{
        let label = UILabel()
        label.text = labelText
        label.font = FontHelper.customFont(size: labelSize)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    lazy var whatLabel = createCustomLabel(labelText: "What Did You Drink?", labelSize: 14)
    lazy var howMuchLabel = createCustomLabel(labelText: "How Much Did You Drink?", labelSize: 14)
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let waterItem = createItemLabel(itemImage: UIImage(named: "water1")!)
        let coffeeItem = createItemLabel(itemImage: UIImage(named: "coffee")!)
        let juiceItem = createItemLabel(itemImage: UIImage(named: "juice")!)
        let teaItem = createItemLabel(itemImage: UIImage(named: "tea")!)
        
        stackView.addArrangedSubview(waterItem)
        stackView.addArrangedSubview(coffeeItem)
        stackView.addArrangedSubview(juiceItem)
        stackView.addArrangedSubview(teaItem)
        return stackView
    }()
    
    private func createItemLabel(itemImage: UIImage) -> UIView {
        let imageView = UIImageView()
        imageView.image = itemImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var barSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 300
        slider.value = 0
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var unitView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        let label = createCustomLabel(labelText: "deneme", labelSize: 12)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLayout()
        view.backgroundColor = .clear
        
    }
    @objc private func handleSlider() {
        print("value changed")
    }
}
extension AddWaterViewController {
    private func setupLayout() {
        
        view.addSubview(containerView)
        view.addSubview(closeButton)
        containerView.addSubview(whatLabel)
        containerView.addSubview(stackView)
        containerView.addSubview(howMuchLabel)
        containerView.addSubview(unitView)
        containerView.addSubview(barSlider)

        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/5),
            containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 8/9),
            containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            whatLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  -24),
            whatLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            whatLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 4/5),
            whatLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/8),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -22),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            
            stackView.topAnchor.constraint(equalTo: whatLabel.bottomAnchor, constant: -24),
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/4),
            
            howMuchLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            howMuchLabel.heightAnchor.constraint(equalToConstant: 36),
            howMuchLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            howMuchLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            unitView.topAnchor.constraint(equalTo: howMuchLabel.bottomAnchor),
            unitView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/7),
            unitView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/3),
            unitView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            barSlider.topAnchor.constraint(equalTo: unitView.bottomAnchor, constant: 12),
            barSlider.heightAnchor.constraint(equalToConstant: 32),
            barSlider.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            barSlider.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
        ])
    }
}
