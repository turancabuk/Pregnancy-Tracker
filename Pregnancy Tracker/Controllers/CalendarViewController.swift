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
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var calendarView: UIDatePicker = {
        let datePicker = UIComponentsFactory.createCustomCalendarView()
        datePicker.addTarget(self, action: #selector(dayTapped), for: .valueChanged)
        return datePicker
    }()
    
    lazy var calendarContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var todoCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .vertical, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDataFromCoredata()
        self.todoCollectionView.reloadData()
    }
    func addDataToCollectionView(_ data: NSManagedObject) {
        savedData.append(data)
        self.todoCollectionView.reloadData()
    }
    fileprivate func fetchDataFromCoredata() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)? .persistentContainer.viewContext else {
            return
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Doctor")
        do{
            savedData = try context.fetch(fetchRequest)
            todoCollectionView.reloadData()
        }catch{
            
        }
    }
    fileprivate func setupLayout() {
        
        view.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendarView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(todoCollectionView)
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            
            calendarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            calendarContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            calendarContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            calendarContainerView.heightAnchor.constraint(equalToConstant: 400),
            
            calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: calendarContainerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.3/5),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            todoCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            todoCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todoCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            todoCollectionView.heightAnchor.constraint(equalToConstant: 220),
            todoCollectionView.bottomAnchor.constraint(equalTo: plusButton.topAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: todoCollectionView.bottomAnchor),
                        
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            plusButton.heightAnchor.constraint(equalToConstant: 60),
            plusButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.savedData[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCellId", for: indexPath) as! CalendarCell
        cell.aboutLabel.text = data.value(forKey: "about") as? String
        cell.noteLabel.text = data.value(forKey: "note") as? String
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
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
