//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        view.backgroundColor = .white
        let safeAreaView = SafeAreaView()
        safeAreaView.setPersonelView(backgroundColor: UIColor(hex: "DEDAF3"))
      
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            safeAreaView.topAnchor.constraint(equalTo: view.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            safeAreaView.personelView.topAnchor.constraint(equalTo: safeAreaView.topAnchor, constant: 50),
            safeAreaView.personelView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            safeAreaView.personelView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaView.personelView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
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

        return CGSize(width: 120, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.collection[indexPath.item]
        let detailVC = CategoriesDetailVC()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.imageView.image = UIImage(named: selectedItem)
        present(detailVC, animated: true)
    }
}
