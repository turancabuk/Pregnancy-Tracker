//
//  SafeAreaView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import UIKit

class SafeAreaView: UIView {
    
    var personelView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createSafeAreaView()
    }
    func createSafeAreaView() {
        let safeAreaView = UIView()
        addSubview(safeAreaView)

        safeAreaView.frame = CGRect(x: 24, y: 50, width: frame.width - 24 * 2 , height: frame.height - 50 * 2)
        safeAreaView.backgroundColor = .white
        safeAreaView.layer.cornerRadius = 16
        safeAreaView.clipsToBounds = true
        
        personelView = UIView()
        addSubview(personelView)
        
        personelView.layer.cornerRadius = 16
        personelView.clipsToBounds = true
        personelView.anchor(
            top: safeAreaView.topAnchor, leading: safeAreaView.leadingAnchor, bottom: nil, trailing: safeAreaView.trailingAnchor, size: .init(width: 0, height: 280))
    }
    func setPersonelView(backgroundColor: UIColor) {
        personelView.backgroundColor = backgroundColor
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
