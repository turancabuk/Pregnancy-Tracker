//
//  WaterViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 4.05.2024.
//

import UIKit
import CoreData

class WaterViewController: UIViewController {
    

    var viewModel: WaterReminderViewModel
    var blurEffectView: UIVisualEffectView?
    let categories = ["water1", "coffee", "tea", "juice"]
    
    var waterLabel: UILabel!
    var coffeeLabel: UILabel!
    var juiceLabel: UILabel!
    var teaLabel: UILabel!

    // Item referansları
    var waterItem: UIView!
    var coffeeItem: UIView!
    var juiceItem: UIView!
    var teaItem: UIView!
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        if let name = UserDefaults.standard.string(forKey: "userName") {
            label.text = "Hi, \(name)"
        }
        label.textColor = .darkGray
        label.font = FontHelper.customFont(size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Today, \(getCurrentDate())"
        label.font = FontHelper.customFont(size: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
    
    lazy var graphicContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        ShadowLayer.setShadow(view: view, color: .black, opacity: 5, offset: .init(width: 0.5, height: 0.5), radius: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        ShadowLayer.setShadow(view: view, color: .black, opacity: 5, offset: .init(width: 0.5, height: 0.5), radius: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var plusButton: UIButton = {
        let button = createCustomButton(buttonImage: "plus")
        button.addTarget(self, action: #selector(handlePlus), for: .touchUpInside)
        return button
    }()
    
    lazy var alertButton: UIButton = {
        let button = createCustomButton(buttonImage: "reminder")
        button.addTarget(self, action: #selector(handleAlert), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        self.viewModel = WaterReminderViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItems()
        setupLayout()
        
        
    }
    func setupItems() {
        (waterItem, waterLabel) = createItems(labelImage: UIImage(named: "water2")!, labelText: "0 ml")
        (juiceItem, juiceLabel) = createItems(labelImage: UIImage(named: "juice1")!, labelText: "0 ml")
        (coffeeItem, coffeeLabel) = createItems(labelImage: UIImage(named: "coffee1")!, labelText: "0 ml")
        (teaItem, teaLabel) = createItems(labelImage: UIImage(named: "tea1")!, labelText: "0 ml")
    }
    @objc fileprivate func handlePlus() {
        let addWaterViewController = AddWaterViewController()
        addWaterViewController.modalPresentationStyle = .overFullScreen
        addWaterViewController.modalTransitionStyle = .crossDissolve
        addWaterViewController.delegate = self
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        present(addWaterViewController, animated: true)
    }
    @objc fileprivate func handleAlert() {
        print("alert button tapped")
    }
    @objc private func handleBack() {
        dismiss(animated: true)
    }
}
extension WaterViewController {
    private func createItems(labelImage: UIImage, labelText: String) -> (UIView, UILabel) {
        let imageView = UIImageView(image: labelImage)
        let label = UILabel()
        label.text = labelText
        label.textColor = .black
        label.font = FontHelper.customFont(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        imageView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 2)
        ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return (imageView, label)
    }
    private func createCustomButton(buttonImage: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: buttonImage), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
extension WaterViewController: AddWaterViewControllerDelegate {
    func updateDrinkQuantity(type: String, quantity: Int) {
        let text = "\(quantity) ml"
        switch type {
        case "water":
            waterLabel.text = text
        case "coffee":
            coffeeLabel.text = text
        case "juice":
            juiceLabel.text = text
        case "tea":
            teaLabel.text = text
        default:
            print("Unexpected drink type")
            return
        }
        print("Updated \(type) quantity to \(quantity) ml")
        blurEffectView?.removeFromSuperview()
    }
    func handleCancel() {
        blurEffectView?.removeFromSuperview()
    }
}
extension WaterViewController {
    private func setupLayout() {
        
        view.addSubview(backButton)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(graphicContainerView)
        view.addSubview(containerView)
        
        containerView.addSubview(waterItem)
        containerView.addSubview(teaItem)
        containerView.addSubview(juiceItem)
        containerView.addSubview(coffeeItem)

        view.addSubview(plusButton)
        view.addSubview(alertButton)
        
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            nameLabel.heightAnchor.constraint(equalToConstant: 36),
            nameLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            dateLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            graphicContainerView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 48),
            graphicContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3),
            graphicContainerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            graphicContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            containerView.topAnchor.constraint(equalTo: graphicContainerView.bottomAnchor, constant: 12),
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/5),
            containerView.widthAnchor.constraint(equalTo: graphicContainerView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: graphicContainerView.centerXAnchor),
            
            waterItem.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            waterItem.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            waterItem.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/5),
            waterItem.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),

            teaItem.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            teaItem.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            teaItem.widthAnchor.constraint(equalTo: waterItem.widthAnchor),
            teaItem.heightAnchor.constraint(equalTo: waterItem.heightAnchor),
            
            juiceItem.topAnchor.constraint(equalTo: waterItem.bottomAnchor, constant: 12),
            juiceItem.leadingAnchor.constraint(equalTo: waterItem.leadingAnchor),
            juiceItem.widthAnchor.constraint(equalTo: waterItem.widthAnchor),
            juiceItem.heightAnchor.constraint(equalTo: waterItem.heightAnchor),
            
            coffeeItem.topAnchor.constraint(equalTo: teaItem.bottomAnchor, constant: 12),
            coffeeItem.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            coffeeItem.widthAnchor.constraint(equalTo: waterItem.widthAnchor),
            coffeeItem.heightAnchor.constraint(equalTo: waterItem.heightAnchor),
            
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            plusButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/6),
            plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            plusButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            
            alertButton.bottomAnchor.constraint(equalTo: graphicContainerView.bottomAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: 72),
            alertButton.widthAnchor.constraint(equalToConstant: 84),
            alertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
}
