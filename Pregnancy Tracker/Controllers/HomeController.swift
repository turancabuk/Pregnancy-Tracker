//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let safeAreaView = SafeAreaView()
    let scrollView = UIScrollView()
    let contentView = UIView()

    let collection = ["development", "nutrition", "water", "mood"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "cellId")
        

        

        setupLayout()
        
        
    }
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        let safeAreaView = SafeAreaView(frame: view.bounds)
        safeAreaView.setPersonelView(backgroundColor: UIColor(hex: "DEDAF3"))
      
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: safeAreaView.centerYAnchor, constant: -50),
            collectionView.centerXAnchor.constraint(equalTo: safeAreaView.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120) // Yükseklik sabit kalabilir veya içeriğe bağlı olarak dinamik olabilir
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HomeCell
        let selectedItem = self.collection[indexPath.item]
        cell.imageView.image = UIImage(named: selectedItem)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let padding: CGFloat = 20
        let minimumInteritemSpacing: CGFloat = 10

        let availableWidth = UIScreen.main.bounds.width - padding - (minimumInteritemSpacing * 2)
        let widthPerItem = availableWidth / 4.7
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 30, bottom: 0, right: 10)
    }
}
