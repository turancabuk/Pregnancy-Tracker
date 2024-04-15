//
//  UICollectionViewCompositionalLayout.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 9.04.2024.
//

//import UIKit
//
//class UICollectionViewCompositionalLayout {
//     func createHorizontalSection(height: CGFloat, itemCount: Int) -> NSCollectionLayoutSection {
//        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / CGFloat(itemCount)), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.4), heightDimension: .absolute(height))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10
//        section.orthogonalScrollingBehavior = .continuous
//        return section
//    }
//
//     func createVerticalSection(itemHeight: CGFloat, itemCount: Int) -> NSCollectionLayoutSection {
//        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.98), heightDimension: .absolute(itemHeight))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(itemHeight * CGFloat(itemCount)))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        return section
//    }
//}
