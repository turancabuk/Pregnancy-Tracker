//
//  CalendarViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 24.04.2024.
//

import UIKit
import CoreData


class CalendarViewModel {
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private var savedData: [NSManagedObject] = []
    var reloadCollectionView: (() -> Void)?
    var readEventVC = ReadEventPopUpViewController()
    
    
    func fetchData() {
        
        guard let context = context else {return}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Doctor")
        
        do{
            savedData = try context.fetch(fetchRequest)
            self.reloadCollectionView!()
        }catch let error {
            print("errror: \(error.localizedDescription)")
        }
    }
    
    func addDataToCollectionView(_ item: NSManagedObject) {
        savedData.append(item)
        fetchData()
    }
    
    func numberOfItemsInSection() -> Int {
        return savedData.count
    }
    
    func configureCell(cell: CalendarCell, at indexPath: IndexPath) {
        let data = savedData[indexPath.item]
        cell.configure(with: data)
                
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
        cell.aboutLabel.text = data.value(forKey: "about") as? String
        cell.onDeleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            let dataToDelete = self.savedData[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(dataToDelete)
                do {
                    try context.save()

                    self.savedData.remove(at: indexPath.row)
                    self.reloadCollectionView!()                } catch let error as NSError {
                    print("Silme işlemi sırasında hata oluştu: \(error), \(error.userInfo)")
                }
            }
        }
    }
    func selectItem(at indexPath: IndexPath) -> NSManagedObject {

        let selectedItem = self.savedData[indexPath.row]
        readEventVC = ReadEventPopUpViewController()
    
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
       
        
        return savedData[indexPath.row]
    }
}
extension CalendarViewModel {
    fileprivate func formattedDateAndTime(from timeInterval: TimeInterval, style: DateFormatter.Style) -> String? {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(style == .short  ? "HH:mm" : "MMM d, yyyy")
        return formatter.string(from: date)
    }
}





