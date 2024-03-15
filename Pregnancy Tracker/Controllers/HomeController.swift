//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var personelView = PersonalInformationView()

    let collection = ["KATEGORİ 1", "KATEGORİ 2", "KATEGORİ 3", "KATEGORİ 4", "KATEGORİ 5", "KATEGORİ 6", "KATEGORİ 7", "KATEGORİ 8", "KATEGORİ 9"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 16
        collectionView.clipsToBounds = true
        return collectionView
    }()
//    let selectedImageLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .left
//        label.textColor = .black
//        label.font = FontHelper.customFont(size: 24)
//        return label
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
    }

    
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        let safeAreaView = SafeAreaView(frame: view.bounds)
        safeAreaView.setPersonelView(backgroundColor: UIColor(hex: "DEDAF3"))
        view.addSubview(safeAreaView)
        
        safeAreaView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaView.topAnchor, constant: 380),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        safeAreaView.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: safeAreaView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor).isActive = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        scrollView.addSubview(contentView)
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: safeAreaView.widthAnchor).isActive = true
        
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
//        view.addSubview(selectedImageLabel)
//        NSLayoutConstraint.activate([
//            selectedImageLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10),
//            selectedImageLabel.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor, constant: 40),
//            selectedImageLabel.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor, constant: -20)
//        ])
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
        return .init(width: 80, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 18, bottom: 0, right: 18)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let index = selectedIndexes.firstIndex(of: indexPath) { // Eğer seçili indeks dizisinde bulunuyorsa
//            selectedIndexes.remove(at: index) // Seçili indeksi kaldır
//            selectedImageLabel.text = ""
//        } else { // Eğer seçili indeks dizisinde bulunmuyorsa
//            selectedIndexes.append(indexPath) // Seçili indeksi ekle
//            let selectedItem = self.collection[indexPath.item]
//            selectedImageLabel.text = "\(selectedItem)"
//        }
//        
//        collectionView.reloadData() // Görünümü yeniden yükle
//    }
}
