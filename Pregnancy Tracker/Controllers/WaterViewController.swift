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
}
extension WaterViewController {
    private func setupLayout() {
        
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(graphicContainerView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            nameLabel.heightAnchor.constraint(equalToConstant: 36),
            nameLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            dateLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            graphicContainerView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            graphicContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3),
            graphicContainerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            graphicContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
