//
//  CategoriesDetailVC.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 15.03.2024.
//

import UIKit

class CategoriesDetailVC: UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 12)
        ])
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    }
    @objc fileprivate func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
