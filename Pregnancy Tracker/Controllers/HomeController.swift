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
    let advertView = AdvertView()
    
    let headerCollection = ["development", "nutrition", "water", "mood"]
    let mainCollection = ["bag", "name", "notes"]
    let verticalCollection = ["development", "nutrition", "water", "mood"]
    let verticalCollectionInfo = ["deneme deneme deneme deneme deneme deneme",
                                  "deneme1 deneme1 deneme1 deneme1 deneme1 deneme1",
                                  "deneme2 deneme2 deneme2 deneme2 deneme2 deneme2",
                                  "deneme3 deneme3 deneme3 deneme3 deneme3 deneme3",
    ]
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var headerCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .horizontal, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var mainCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .horizontal, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    lazy var verticalCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .vertical, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        headerCollectionView.register(HeaderCategoriesCell.self, forCellWithReuseIdentifier: "headerCategoriesCellId")
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCategoriesCellId")
        verticalCollectionView.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: "verticalCollectionViewCellId")
        
        setupLayout()
        
    }
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        safeAreaView.setPersonelView(backgroundColor: UIColor(hex: "F2B5D4"))
        tabBarController?.tabBar.backgroundColor = .white

        view.addSubview(safeAreaView)
        safeAreaView.addSubview(seperatorView)
        safeAreaView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerCollectionView)
        contentView.addSubview(mainCollectionView)
        contentView.addSubview(advertView)
        contentView.addSubview(verticalCollectionView)

        disableAutoResizingMaskConstraints(for: [safeAreaView, seperatorView, scrollView, contentView, headerCollectionView, mainCollectionView, advertView, verticalCollectionView])

        scrollView.isScrollEnabled = true
        
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaView.personelView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            seperatorView.topAnchor.constraint(equalTo: view.topAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: safeAreaView.personelView.topAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),

            mainCollectionView.topAnchor.constraint(equalTo: headerCollectionView.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            advertView.topAnchor.constraint(equalTo: mainCollectionView.bottomAnchor),
            advertView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor, constant: 10),
            advertView.bottomAnchor.constraint(equalTo: verticalCollectionView.topAnchor, constant: -24),
            advertView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor, constant: -10),
            advertView.heightAnchor.constraint(equalToConstant: 40),
            
            verticalCollectionView.topAnchor.constraint(equalTo: advertView.bottomAnchor, constant: 6),
            verticalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            verticalCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            verticalCollectionView.heightAnchor.constraint(equalToConstant: 480),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

        ])
        
        if let lastView = contentView.subviews.last {
            NSLayoutConstraint.activate([
                lastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ])
        }
        safeAreaView.backgroundColor = .orange
    }
    fileprivate func disableAutoResizingMaskConstraints(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case headerCollectionView:
            return headerCollection.count
        case mainCollectionView:
            return mainCollection.count
        case verticalCollectionView:
            return verticalCollection.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case headerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCategoriesCellId", for: indexPath) as! HeaderCategoriesCell
            let selectedItem = self.headerCollection[indexPath.item]
            cell.imageView.image = UIImage(named: selectedItem)
            return cell
        case mainCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCategoriesCellId", for: indexPath) as! MainCollectionViewCell
            let selectedItem = self.mainCollection[indexPath.item]
            cell.imageView.image = UIImage(named: selectedItem)
            return cell
        case verticalCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCollectionViewCellId", for: indexPath) as! VerticalCollectionViewCell
            let selectedItem = self.verticalCollection[indexPath.item]
            cell.imageView.image = UIImage(named: selectedItem)
            cell.infoLabel.text = self.verticalCollectionInfo[indexPath.item]
            return cell
        default:
            fatalError()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case headerCollectionView:
            return CGSize(width: 120, height: 120)
        case mainCollectionView:
            return CGSize(width: 240, height: 240)
        case verticalCollectionView:
            return CGSize(width: view.frame.width - 30, height: 100)
        default:
           fatalError()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case headerCollectionView:
            return .init(top: 0, left: 12, bottom: 0, right: 12)
        case mainCollectionView:
            return .init(top: 0, left: 12, bottom: 0, right: 12)
        case verticalCollectionView:
            return .init(top: 0, left: 18, bottom: 0, right: 18)
        default:
            fatalError()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case headerCollectionView:
            let selectedItem = self.headerCollection[indexPath.item]
            let detailVC = CategoriesDetailVC()
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.imageView.image = UIImage(named: selectedItem)
            present(detailVC, animated: true)
        case mainCollectionView:
            let selectedItem = self.mainCollection[indexPath.item]
            let detailVC = CategoriesDetailVC()
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.imageView.image = UIImage(named: selectedItem)
            present(detailVC, animated: true)
        case verticalCollectionView:
            let selectedItem = self.verticalCollection[indexPath.item]
            let detailVC = CategoriesDetailVC()
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.imageView.image = UIImage(named: selectedItem)
            present(detailVC, animated: true)
        default:
            fatalError()
        }
    }
}
