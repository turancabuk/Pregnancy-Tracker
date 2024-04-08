//
//  ReadEventPopUpViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.04.2024.
//

import UIKit

class ReadEventPopUpViewController: UIViewController{
    
    private func createCustomLabel(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textColor = .white
        label.font = FontHelper.customFont(size: fontSize)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "ffc2b4")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "", state: .normal, titleColor: UIColor.clear, borderColor: UIColor.clear, borderWidth: 0.0, cornerRadius: 0, clipsToBounds: false, action: handleClose)
        button.setImage(UIImage(named: "cancel"), for: .normal)
        return button
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = FontHelper.customFont(size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontHelper.customFont(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var aboutLabel: UILabel = {
        let label = createCustomLabel(fontSize: 16)
        return label
    }()
    
    lazy var noteLabel: UILabel = {
        let label = createCustomLabel(fontSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    @objc func handleClose() {
        self.dismiss(animated: true)
        print("close button tapped")
    }
}
extension ReadEventPopUpViewController {
    fileprivate func setupLayout() {
        self.preferredContentSize = CGSize(width: 320, height: 360)
        view.addSubview(containerView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(closeButton)
        containerView.addSubview(seperatorView)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(noteLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: preferredContentSize.width),
            containerView.heightAnchor.constraint(equalToConstant: preferredContentSize.height),
            
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/2),
            dateLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5),
            
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            timeLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/3),
            timeLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/5),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            closeButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/8),
            closeButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/9),
            
            seperatorView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            seperatorView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 4/5),
            seperatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 6),
            
            aboutLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 14),
            aboutLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 4/5),
            aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            aboutLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/6),
            
            noteLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            noteLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 4/5),
            noteLabel.leadingAnchor.constraint(equalTo: aboutLabel.leadingAnchor),
            noteLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 2/4)
        ])
    }
}
