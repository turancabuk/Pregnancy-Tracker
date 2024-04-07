//
//  CalendarViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 3.04.2024.
//

import UIKit
import CoreData

protocol CalendarViewControllerDelegate: AnyObject{
    func didSelectDate(date: Date)
}
class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddEventPopUpViewControllerDelegate{
    
    
    var savedData: [NSManagedObject] = []
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 12
        scrollView.clipsToBounds = true
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
        view.translatesAutoresizingMaskIntoConstraints = false
        ShadowLayer.setShadow(view: view, color: .black, opacity: 3.0, offset: .init(width: 1.0, height: 1.0), radius: 4)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var calendarView: UIDatePicker = {
        let datePicker = UIComponentsFactory.createCustomCalendarView()
        datePicker.addTarget(self, action: #selector(dayTapped(selectedDate:)), for: .valueChanged)
        datePicker.backgroundColor = UIColor(hex: "ffc2b4")
        return datePicker
    }()

    lazy var todoCollectionView: UICollectionView = {
        let collectionView = UIComponentsFactory.createCustomCollectionView(scrollDirection: .vertical, bg: .clear, spacing: 12)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        todoCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCellId")

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDataFromCoredata()
        self.todoCollectionView.reloadData()
        didAddEvent()
    }
    func didAddEvent() {
        fetchDataFromCoredata()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCellId", for: indexPath) as! CalendarCell
        
        let data = self.savedData[indexPath.item]
        
        if let dateData = data.value(forKey: "date") as? Int32 {
            if let dateString = formattedDateAndTime(from: TimeInterval(dateData), style: .medium){
                cell.dateLabel.text = dateString
            }
        }
        
        if let timeData = data.value(forKey: "time") as? Int32 {
            if let timeString = formattedDateAndTime(from: TimeInterval(timeData), style: .short){
                cell.timeLabel.text = timeString
            }
        }
        cell.onDeleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            let dataToDelete = self.savedData[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(dataToDelete)
                do {
                    try context.save()

                    self.savedData.remove(at: indexPath.row)

                    self.todoCollectionView.performBatchUpdates({
                        self.todoCollectionView.deleteItems(at: [indexPath])
                    })
                } catch let error as NSError {
                    print("Silme işlemi sırasında hata oluştu: \(error), \(error.userInfo)")
                }
            }
        }

        cell.aboutLabel.text = data.value(forKey: "about") as? String
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = self.savedData[indexPath.row]
        let readEventVC = ReadEventPopUpViewController()
    
        if let dateData = selectedItem.value(forKey: "date") as? Int32 {
            if let dateString = formattedDateAndTime(from: TimeInterval(dateData), style: .medium) {
                readEventVC.dateLabel.text = dateString
            }
        }
        
        if let timeData = selectedItem.value(forKey: "time") as? Int32 {
            if let timeString = formattedDateAndTime(from: TimeInterval(timeData), style: .short) {
                readEventVC.timeLabel.text = timeString
            }
        }
        
        readEventVC.aboutLabel.text = selectedItem.value(forKey: "about") as? String
        readEventVC.noteLabel.text = selectedItem.value(forKey: "note") as? String
        
        readEventVC.preferredContentSize = CGSize(width: 320, height: 360)
        readEventVC.modalPresentationStyle = .popover
        self.present(readEventVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    @objc fileprivate func dayTapped(selectedDate: UIDatePicker) {
       
        let selectedDate = selectedDate.date
        
        let popupViewController = AddEventPopUpViewController()
        popupViewController.modalPresentationStyle = .popover
        popupViewController.selectedDate = selectedDate
        popupViewController.delegate = self
        
        if let popupVC = popupViewController.popoverPresentationController {
            
            popupVC.sourceView = self.view
            popupVC.sourceRect = CGRect(x: self.view.bounds.minX, y: self.view.bounds.minY, width: 0, height: 0)
            popupVC.permittedArrowDirections = []
            popupViewController.preferredContentSize = CGSize(width: 320, height: 360)
            
        }
        self.present(popupViewController, animated: true, completion: nil)
    }
}
extension CalendarViewController {
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(hex: "fcefef")

        view.addSubview(calendarContainerLayerView)
        calendarContainerLayerView.addSubview(calendarContainerView)
        calendarContainerView.addSubview(calendarView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(todoCollectionView)
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
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/5),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            todoCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            todoCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            todoCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            todoCollectionView.heightAnchor.constraint(equalToConstant: 220),
            todoCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: todoCollectionView.bottomAnchor),
        ])
    }
}
extension CalendarViewController {
    fileprivate func formattedDateAndTime(from timeInterval: TimeInterval, style: DateFormatter.Style) -> String? {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(style == .short  ? "HH:mm" : "MMM d, yyyy")
        return formatter.string(from: date)
    }
}
