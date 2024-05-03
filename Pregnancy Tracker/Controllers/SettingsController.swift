//
//  SettingsController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit


class SettingsController: UIViewController {
    
    var viewModel: SettingsViewModel
    var customColour = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    let customColour1 = UIColor(red: 0.8667, green: 0.7451, blue: 0.6588, alpha: 0.4)
    let backgroundColor = UIColor(hex: "ddbea8")
    
    
    lazy var safeAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.8667, green: 0.7451, blue: 0.6588, alpha: 0.4)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "contactImage")
        imageView.contentMode = .scaleAspectFit
        ShadowLayer.setShadow(view: imageView, color: UIColor.black, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var advertView: UIView = {
        let view = AdvertView()
        view.getButton.addTarget(self, action: #selector(handleGetAdvert), for: .touchUpInside)
        return view
    }()
    
    lazy var shareButton = createCustomSettingsButton(title: "Share Us", image: UIImage(named: "shareButton")!, action: #selector(shareTapped))
    lazy var rateButton = createCustomSettingsButton(title: "Rate Us", image: UIImage(named: "rateButton")!, action: #selector(rateTapped))
    lazy var contactButton = createCustomSettingsButton(title: "Contact Us", image: UIImage(named: "contactButton")!, action: #selector(contactTapped))
    lazy var privacyButton = createCustomSettingsButton(title: "Privacy Policy", image: UIImage(named: "privacyButton")!, action: #selector(privacyTapped))
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shareButton, rateButton, contactButton, privacyButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        self.viewModel = SettingsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()

        
    }
    @objc func shareTapped() {
        viewModel.shareButtonConfgs()
    }

    @objc func rateTapped() {
        viewModel.rateButtonConfgs()
    }

    @objc func contactTapped() {
        viewModel.contactButtonConfgs()
    }
    
    @objc func privacyTapped() {
        viewModel.privacyButtonConfgs()
    }
    
    @objc func handleGetAdvert() {
        viewModel.advertViewContact()
    }
}
extension SettingsController {
    private func createCustomSettingsButton(title: String, image: UIImage, action: Selector) -> UIButton {
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = FontHelper.customFont(size: 22)
        titleLabel.textColor = .darkGray
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.addSubview(imageView)
        button.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 7),
            imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -7),
            imageView.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.4),
            imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: button.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.6),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10)
            
        ])
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        ShadowLayer.setShadow(view: button, color: .darkGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 5)
        button.backgroundColor = UIColor(hex: "ddbea8")
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
extension SettingsController {
    fileprivate func setupLayout(){
        view.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        view.addSubview(safeAreaView)
        view.addSubview(stackView)
        safeAreaView.addSubview(imageView)
        safeAreaView.addSubview(advertView)
        
        advertView.translatesAutoresizingMaskIntoConstraints = false
        ShadowLayer.setShadow(view: advertView, color: .darkGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 5)
        
        NSLayoutConstraint.activate([
            
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 54),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 3/5),
            imageView.widthAnchor.constraint(equalTo: safeAreaView.widthAnchor, multiplier: 3/5),
            imageView.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            
            stackView.bottomAnchor.constraint(equalTo: advertView.topAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 5/6),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            advertView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -54),
            advertView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/5),
            advertView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: 12),
            advertView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
            
        ])
    }
}
