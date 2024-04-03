//
//  CalendarViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 3.04.2024.
//

import UIKit
import CoreData

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var savedData: [NSManagedObject] = []
    var items = ["development", "nutrition", "water", "mood"]
    
    lazy var calendarView: UIDatePicker = {
        let datePicker = UIComponentsFactory.createCustomCalendarView()
        datePicker.addTarget(self, action: #selector(dayTapped), for: .valueChanged)
        return datePicker
    }()
    
    lazy var calendarContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3.0
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var todoCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .vertical, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        return collectionView
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "", state: .normal, titleColor: .clear, borderColor: .clear, borderWidth: 0.0, cornerRadius: 0, clipsToBounds: false, action: plusButtonTapped)
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        view.backgroundColor = .white
        todoCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCellId")

        
    }
    fileprivate func setupLayout() {
        
        view.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendarView)
        view.addSubview(todoCollectionView)
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            
            calendarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:  36),
            calendarContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            calendarContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            calendarContainerView.heightAnchor.constraint(equalToConstant: 400),
            
            calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            
            todoCollectionView.topAnchor.constraint(equalTo: calendarContainerView.bottomAnchor, constant: 12),
            todoCollectionView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            todoCollectionView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            todoCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            plusButton.heightAnchor.constraint(equalToConstant: 60),
            plusButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    func addDataToCollectionView(_ data: NSManagedObject) {
        savedData.append(data)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = savedData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCellId", for: indexPath) as! CalendarCell
        cell.aboutLabel.text = data.value(forKey: "about") as? String
        cell.noteLabel.text = data.value(forKey: "note") as? String
        return cell
    }
    @objc fileprivate func dayTapped() {
        print("day tapped ")
    }
    @objc fileprivate func plusButtonTapped() {
        let calendarDetailVC = CalendarDetailController()
        calendarDetailVC.modalPresentationStyle = .fullScreen
        present(calendarDetailVC, animated: true)
    }
}
