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
    let categories = ["water1", "coffee", "tea", "juice"]
    
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
    
    lazy var waterItem = createItems(labelImage: UIImage(named: "water2")!, labelText: "200 ml")
    lazy var juiceItem = createItems(labelImage: UIImage(named: "juice1")!, labelText: "200 ml")
    lazy var coffeeItem = createItems(labelImage: UIImage(named: "coffee1")!, labelText: "200 ml")
    lazy var teaItem = createItems(labelImage: UIImage(named: "tea1")!, labelText: "200 ml")
    
    lazy var plusButton: UIButton = {
        let button = createCustomButton(buttonImage: "plus")
        button.addTarget(self, action: #selector(handlePlus), for: .touchUpInside)
        return button
    }()
    
    lazy var alertButton : UIButton = {
        let button = createCustomButton(buttonImage: "reminder")
        button.addTarget(self, action: #selector(handleAlert), for: .touchUpInside)
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
        
        
        setupLayout()
        
        
    }
    @objc fileprivate func handlePlus() {
        let addWaterViewController = AddWaterViewController()
        addWaterViewController.modalPresentationStyle = .overFullScreen
        addWaterViewController.modalTransitionStyle = .crossDissolve
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        present(addWaterViewController, animated: true)
    }


    @objc fileprivate func handleAlert() {
        print("alert button tapped")
    }
}
extension WaterViewController {
    private func createItems(labelImage: UIImage, labelText: String) -> UIView{
        let imageView = UIImageView(image: labelImage)
        let label = UILabel()
        label.text = labelText
        label.textColor = .black
        label.font = FontHelper.customFont(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(label)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 20),
            label.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1/2.5),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 2)
        ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    private func createCustomButton(buttonImage: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: buttonImage), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
extension WaterViewController {
    private func setupLayout() {
        
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
            
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            alertButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/8),
            alertButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            alertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24)
        ])
    }
}