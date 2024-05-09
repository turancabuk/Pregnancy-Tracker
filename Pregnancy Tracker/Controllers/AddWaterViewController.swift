//
//  AddWaterViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.05.2024.
//

import UIKit


protocol AddWaterViewControllerDelegate: AnyObject {
    func handleCancel()
    
}
class AddWaterViewController: UIViewController {
    
    weak var delegate: AddWaterViewControllerDelegate?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var whatLabel = createCustomLabel(labelText: "What Did You Drink?", labelSize: 14)
    lazy var howMuchLabel = createCustomLabel(labelText: "How Much Did You Drink?", labelSize: 14)
    lazy var zeroLabel = createCustomLabel(labelText: "0 ml", labelSize: 10)
    lazy var threeHundredLabel = createCustomLabel(labelText: "300 ml", labelSize: 10)
    
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
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var barSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 300
        slider.value = 0
        slider.addTarget(self, action: #selector(handleSlider(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var unitLabel: UILabel = {
        let label = createCustomLabel(labelText: "0 ml", labelSize: 24)
        label.textColor = .orange
        return label
    }()
    
    lazy var unitView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9913895726, green: 0.9271829128, blue: 0.8677335382, alpha: 1)
        view.addSubview(unitLabel)
        
        NSLayoutConstraint.activate([
            unitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unitLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "ADD", state: .normal, titleColor: UIColor.white, borderColor: UIColor.clear, borderWidth: 2.0, cornerRadius: 12, clipsToBounds: true, action: handleAdd)
        button.titleLabel?.font = FontHelper.customFont(size: 12)
        button.backgroundColor = #colorLiteral(red: 0.0004648703907, green: 0.5735016465, blue: 0.9910971522, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLayout()
        view.backgroundColor = .clear
        
    }
    @objc private func handleSlider(_ sender: UISlider) {
        unitLabel.text = "\(Int(sender.value)) ml"
    }
    @objc private func handleCancel() {
        delegate?.handleCancel()
        dismiss(animated: true)
    }
    @objc private func handleAdd() {
        print("added")
    }
}
extension AddWaterViewController {
    private func createCustomLabel(labelText: String, labelSize: CGFloat) -> UILabel{
        let label = UILabel()
        label.text = labelText
        label.font = FontHelper.customFont(size: labelSize)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    private func createItemLabel(itemImage: UIImage) -> UIView {
        let imageView = UIImageView()
        imageView.image = itemImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        containerView.addSubview(zeroLabel)
        containerView.addSubview(threeHundredLabel)
        containerView.addSubview(addButton)

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
            
            unitView.topAnchor.constraint(equalTo: howMuchLabel.bottomAnchor, constant: 12),
            unitView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/7),
            unitView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/3),
            unitView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            barSlider.topAnchor.constraint(equalTo: unitView.bottomAnchor, constant: 12),
            barSlider.heightAnchor.constraint(equalToConstant: 32),
            barSlider.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            barSlider.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            zeroLabel.topAnchor.constraint(equalTo: barSlider.bottomAnchor),
            zeroLabel.heightAnchor.constraint(equalToConstant: 20),
            zeroLabel.widthAnchor.constraint(equalToConstant: 46),
            zeroLabel.leadingAnchor.constraint(equalTo: barSlider.leadingAnchor, constant: 6),
            
            threeHundredLabel.topAnchor.constraint(equalTo: barSlider.bottomAnchor),
            threeHundredLabel.heightAnchor.constraint(equalToConstant: 20),
            threeHundredLabel.widthAnchor.constraint(equalToConstant: 36),
            threeHundredLabel.trailingAnchor.constraint(equalTo: barSlider.trailingAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            addButton.heightAnchor.constraint(equalToConstant: 46),
            addButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 3/4),
            addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            
        ])
    }
}
