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
    
    lazy var calendarContainerLayerView: UIView = {
       let view = UIView()
        ShadowLayer.setShadow(view: view, color: .lightGray, opacity: 1.0, offset: .init(width: 0.5, height: 0.5), radius: 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var calendarContainerView: UIView = {
        let view = UIView()
//        view.layer.borderColor = UIColor.white.cgColor
//        view.layer.borderWidth = 3.0
        view.translatesAutoresizingMaskIntoConstraints = false
        ShadowLayer.setShadow(view: view, color: .black, opacity: 3.0, offset: .init(width: 1.0, height: 1.0), radius: 4)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var calendarView: UIDatePicker = {
        let datePicker = UIComponentsFactory.createCustomCalendarView()
        datePicker.addTarget(self, action: #selector(dayTapped), for: .valueChanged)
        datePicker.backgroundColor = UIColor(hex: "ffc2b4")
        return datePicker
    }()

    lazy var todoCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .vertical, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        view.backgroundColor = UIColor(hex: "f79256")
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
extension CalendarViewController {
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(hex: "f79256")
        
        view.addSubview(calendarContainerLayerView)
        calendarContainerLayerView.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendarView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(todoCollectionView)
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            
            calendarContainerLayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            calendarContainerLayerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            calendarContainerLayerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            calendarContainerLayerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.7/3.5),
            
            calendarContainerView.topAnchor.constraint(equalTo: calendarContainerLayerView.topAnchor),
            calendarContainerView.leadingAnchor.constraint(equalTo: calendarContainerLayerView.leadingAnchor),
            calendarContainerView.bottomAnchor.constraint(equalTo: calendarContainerLayerView.bottomAnchor),
            calendarContainerView.trailingAnchor.constraint(equalTo: calendarContainerLayerView.trailingAnchor),
            
            calendarView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            calendarView.heightAnchor.constraint(equalTo: calendarContainerView.heightAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: calendarContainerView.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: calendarContainerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: calendarContainerView.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.3/5),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            todoCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
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
}
