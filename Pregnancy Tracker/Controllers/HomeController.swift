//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit

class HomeController: UIViewController, UICollectionViewDelegate {
        
    let safeAreaView = SafeAreaView()
    let profileController = ProfileController()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let advertView = AdvertView()
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    var collectionView: UICollectionView!
    
    
    enum Section: Int, CaseIterable {
        case header
        case main
        case vertical
        case foodDiet
    }
        
    let headerCollection = ["development", "water", "nutrition", "mood"]
    let mainCollection = ["bag", "name", "notes"]
    let verticalCollection = ["1", "2", "3", "4"]
    let verticalCollectionInfo = ["deneme deneme deneme deneme deneme deneme",
                                  "deneme1 deneme1 deneme1 deneme1 deneme1 deneme1",
                                  "deneme2 deneme2 deneme2 deneme2 deneme2 deneme2",
                                  "deneme3 deneme3 deneme3 deneme3 deneme3 deneme3",
    ]
    let foodAndDietCollection = ["diet", "food"]
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "f79256")
        return view
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupCollectionView()
        collectionView.delegate = self
        setupLayout()
        safeAreaView.viewModel = SafeAreaViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        safeAreaView.updateUI()
    }
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        

        collectionView.register(HeaderCategoriesCell.self, forCellWithReuseIdentifier: "headerCategoriesCellId")
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCategoriesCellId")
        collectionView.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: "verticalCollectionViewCellId")
        collectionView.register(FoodandDietCell.self, forCellWithReuseIdentifier: "foodAndDietCell")
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView){
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            
            switch Section(rawValue: indexPath.section)! {
            case .header:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCategoriesCellId", for: indexPath) as! HeaderCategoriesCell
                cell.imageView.image = UIImage(named: identifier)
                return cell
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCategoriesCellId", for: indexPath) as! MainCollectionViewCell
                cell.imageView.image = UIImage(named: identifier)
                return cell
            case .vertical:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCollectionViewCellId", for: indexPath) as! VerticalCollectionViewCell
                cell.imageView.image = UIImage(named: identifier)
                cell.infoLabel.text = self.verticalCollectionInfo[indexPath.item]
                return cell
            case .foodDiet:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodAndDietCell", for: indexPath) as! FoodandDietCell
                cell.imageView.image = UIImage(named: identifier)
                return cell
            }
        }
        applyInitialSnapshot()
    }
    private func applyInitialSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        Section.allCases.forEach { section in
            snapshot.appendSections([section])
            switch section {
            case .header:
                snapshot.appendItems(headerCollection, toSection: .header)
            case .main:
                snapshot.appendItems(mainCollection, toSection: .main)
            case .vertical:
                snapshot.appendItems(verticalCollection, toSection: .vertical)
            case .foodDiet:
                snapshot.appendItems(foodAndDietCollection, toSection: .foodDiet)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    private func createCompositionalLayout() -> UICollectionViewLayout {
        
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self = self else {return nil}
            guard let section = Section(rawValue: sectionIndex) else {return nil}
            
            switch section {
            case .header:
                return self.createHorizontalSection(height: 120, itemCount: self.headerCollection.count)
            case .main:
                return self.createHorizontalSection(height: 240, itemCount: self.mainCollection.count)
            case .vertical:
                return self.createVerticalSection(itemHeight: 100, itemCount: self.verticalCollection.count)
            case .foodDiet:
                return self.createHorizontalSection(height: 200, itemCount: self.foodAndDietCollection.count)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch Section(rawValue: indexPath.section)! {
        case .header:
            let selectedItem = headerCollection[indexPath.row]
            uniqueSelectedItem(selectedItem)
        case .main:
            let selectedItem = mainCollection[indexPath.row]
            uniqueSelectedItem(selectedItem)
        case .vertical:
            let selectedItem = verticalCollection[indexPath.row]
            uniqueSelectedItem(selectedItem)
        case .foodDiet:
            let selectedItem = foodAndDietCollection[indexPath.row]
            let detVC = FoodAndDietView()
            if selectedItem == "diet" {
                detVC.imageView.image = UIImage(named: "diet")
                let dietDetail = DietAndFoodInfoProvider.shared.getDietDescription(for: .diet)
                detVC.foodDietLabel.text = dietDetail
            }else{
                detVC.imageView.image = UIImage(named: "food")
                let foodDetail = DietAndFoodInfoProvider.shared.getDietDescription(for: .food)
                detVC.foodDietLabel.text = foodDetail
            }
            detVC.modalPresentationStyle = .fullScreen
            present(detVC, animated: true)
        default:
            fatalError()
        }
    }
    fileprivate func uniqueSelectedItem(_ selectedItem: String) {
        let detailVC = CategoriesDetailVC()
        detailVC.imageView.image = UIImage(named: selectedItem)
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
extension HomeController {
    private func createHorizontalSection(height: CGFloat, itemCount: Int) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(itemCount)), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.4), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    private func createVerticalSection(itemHeight: CGFloat, itemCount: Int) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight * CGFloat(itemCount)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
extension HomeController {
    fileprivate func setupLayout() {
        view.addSubview(safeAreaView)
        safeAreaView.setPersonelView(backgroundColor: UIColor(hex: "f79256"))
        tabBarController?.tabBar.backgroundColor = .white

        
        safeAreaView.addSubview(seperatorView)
        safeAreaView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(advertView)
        
        disableAutoResizingMaskConstraints(for: [safeAreaView, seperatorView, scrollView, contentView, advertView, collectionView])

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
            
            seperatorView.topAnchor.constraint(equalTo: view.topAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: safeAreaView.personelView.topAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 700),
            
            advertView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12),
            advertView.widthAnchor.constraint(equalTo: collectionView.widthAnchor, constant: -6),
            advertView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            advertView.heightAnchor.constraint(equalToConstant: 40),
            
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
}


