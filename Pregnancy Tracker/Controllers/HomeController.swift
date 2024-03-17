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

    let headerCollection = ["development", "nutrition", "water", "mood"]
    let mainCollection = ["bag", "name", "notes"]
    
    
    func createCollectionView(scrollDirection: UICollectionView.ScrollDirection, bg: UIColor, spacing: CGFloat) -> UICollectionView{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = bg
        return collectionView
    }
    lazy var headerCollectionView: UICollectionView = {
        createCollectionView(scrollDirection: .horizontal, bg: .clear, spacing: 12)
    }()
    lazy var mainCollectionView: UICollectionView = {
        createCollectionView(scrollDirection: .horizontal, bg: .clear, spacing: 12)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        headerCollectionView.register(HeaderCategoriesCell.self, forCellWithReuseIdentifier: "headerCategoriesCellId")
        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCategoriesCellId")
        setupLayout()
        
    }
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let safeAreaView = SafeAreaView()
        safeAreaView.setPersonelView(backgroundColor: UIColor(hex: "DEDAF3"))
      
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerCollectionView)
        contentView.addSubview(mainCollectionView)
        
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        headerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            safeAreaView.topAnchor.constraint(equalTo: view.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            
            headerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            headerCollectionView.heightAnchor.constraint(equalToConstant: 140),
            headerCollectionView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            
            mainCollectionView.topAnchor.constraint(equalTo: headerCollectionView.bottomAnchor, constant: 20),
            mainCollectionView.widthAnchor.constraint(equalTo: safeAreaView.widthAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            mainCollectionView.heightAnchor.constraint(equalToConstant: 300),
        ])
        contentView.backgroundColor = .orange
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case headerCollectionView:
            return headerCollection.count
        case mainCollectionView:
            return mainCollection.count
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
        default:
            fatalError()
        }
    }
}
