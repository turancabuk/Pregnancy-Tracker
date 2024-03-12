//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var personelView = PersonalInformationView()
    
    let personalCardColor = #colorLiteral(red: 0.9507680535, green: 0.7077944875, blue: 0.8335040212, alpha: 1)
    let collection = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 16
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if isFirstLaunch {
            UserDefaults.standard.setValue(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.synchronize()
            
            self.showPersonalInfoView()
        }
    }
    fileprivate func showPersonalInfoView() {

        let personalInfoView = PersonalInformationView()
        personalInfoView.modalPresentationStyle = .fullScreen
        self.present(personalInfoView, animated: true, completion: nil)
    }
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        let safeAreaView = SafeAreaView(frame: view.bounds)
        safeAreaView.setPersonelView(backgroundColor: personalCardColor)
        view.addSubview(safeAreaView)
        
        safeAreaView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaView.topAnchor, constant: 380),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalToConstant: 120)
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
        return .init(width: 110, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 18, bottom: 0, right: 18)
    }
}
