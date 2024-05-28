//
//  HomeViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 1.05.2024.
//

import UIKit
import SwiftUI

class HomeViewModel {
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    let foodAndDietCollection = ["diet", "food"]
    let mainCollection = ["yuri", "zoran", "dolga"]
    let verticalCollection = ["1", "2", "3", "4"]
    let verticalCollectionInfo = ["deneme deneme deneme deneme deneme deneme",
                                  "deneme1 deneme1 deneme1 deneme1 deneme1 deneme1",
                                  "deneme2 deneme2 deneme2 deneme2 deneme2 deneme2",
                                  "deneme3 deneme3 deneme3 deneme3 deneme3 deneme3",
    ]
    
    enum Section: Int, CaseIterable {
        case main
        case vertical
        case foodDiet
    }
    func setupCollectionView(controller: HomeController) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        controller.viewModel.collectionView = self.collectionView

        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "mainCategoriesCellId")
        collectionView.register(VerticalCollectionViewCell.self, forCellWithReuseIdentifier: "verticalCollectionViewCellId")
        collectionView.register(FoodandDietCell.self, forCellWithReuseIdentifier: "foodAndDietCell")
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView){
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in
            
            switch Section(rawValue: indexPath.section)! {
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
            case .main:
                return self.createHorizontalSection(height: 240, itemCount: self.mainCollection.count)
            case .vertical:
                return self.createVerticalSection(itemHeight: 100, itemCount: self.verticalCollection.count)
            case .foodDiet:
                return self.createHorizontalSection(height: 200, itemCount: self.foodAndDietCollection.count)
            }
        }
    }
    func didSelect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, viewController: UIViewController) {
        
        switch Section(rawValue: indexPath.section)! {
        case .main:
            let selectedItem = mainCollection[indexPath.row]
            uniqueSelectedItem(selectedItem, controller: viewController, detailController: CategoriesDetailVC(), backgroundColor: .blue)
        case .vertical:
            let selectedItem = verticalCollection[indexPath.row]
            uniqueSelectedItem(selectedItem, controller: viewController, detailController: CategoriesDetailVC(), backgroundColor: .yellow)
        case .foodDiet:
            let selectedItem = foodAndDietCollection[indexPath.row]
            let detVC = FoodAndDietView()
            if selectedItem == "diet" {
                detVC.imageView.image = UIImage(named: "diet1")
            } else {
                detVC.imageView.image = UIImage(named: "food1")
            }
            detVC.modalPresentationStyle = .fullScreen
            viewController.present(detVC, animated: true)
        }
    }

    fileprivate func uniqueSelectedItem(_ selectedItem: String, controller: UIViewController, detailController: UIViewController, backgroundColor: UIColor) {
        let detailVC = detailController
        detailVC.view.backgroundColor = backgroundColor
        detailVC.modalPresentationStyle = .fullScreen
        controller.present(detailVC, animated: true)
    }

    func advertViewContact() {
        if let url = URL(string: "https://apps.apple.com/us/app/little-steps-development/id6474306976") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
