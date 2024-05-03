//
//  HomeViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 1.05.2024.
//

import UIKit

class HomeViewModel {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    let foodAndDietCollection = ["diet", "food"]
    let headerCollection = ["development", "water", "nutrition", "mood"]
    let mainCollection = ["bag", "name", "notes"]
    let verticalCollection = ["1", "2", "3", "4"]
    let verticalCollectionInfo = ["deneme deneme deneme deneme deneme deneme",
                                  "deneme1 deneme1 deneme1 deneme1 deneme1 deneme1",
                                  "deneme2 deneme2 deneme2 deneme2 deneme2 deneme2",
                                  "deneme3 deneme3 deneme3 deneme3 deneme3 deneme3",
    ]
    
    enum Section: Int, CaseIterable {
        case header
        case main
        case vertical
        case foodDiet
    }
    

    func setupCollectionView(controller: HomeController) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        controller.viewModel.collectionView = self.collectionView

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
    func applyInitialSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        Section.allCases.forEach { section in
            snapshot.appendSections([section])
            switch section {
            case .header:
                snapshot.appendItems(self.headerCollection, toSection: .header)
            case .main:
                snapshot.appendItems(self.mainCollection, toSection: .main)
            case .vertical:
                snapshot.appendItems(self.verticalCollection, toSection: .vertical)
            case .foodDiet:
                snapshot.appendItems(self.foodAndDietCollection, toSection: .foodDiet)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func createCompositionalLayout() -> UICollectionViewLayout {
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
}
extension HomeViewModel {
    func createHorizontalSection(height: CGFloat, itemCount: Int) -> NSCollectionLayoutSection {
        
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
    func createVerticalSection(itemHeight: CGFloat, itemCount: Int) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .absolute(itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight * CGFloat(itemCount)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
