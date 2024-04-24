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
    
    func fetchData(completion: @escaping () -> Void) {
        
        guard let context = context else {return}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Doctor")
        
        do{
            savedData = try context.fetch(fetchRequest)
            reloadCollectionView
        }catch let error {
            print("errror: \(error.localizedDescription)")
        }
    }
    
    func addDataToCollectionView(_ item: NSManagedObject) {
        savedData.append(item)
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
//        cell.onDeleteButtonTapped = { [weak self] in
//            guard let self = self else { return }
//            let dataToDelete = self.savedData[indexPath.row]
//            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//                context.delete(dataToDelete)
//                do {
//                    try context.save()
//
//                    self.savedData.remove(at: indexPath.row)
//
//                    self.todoCollectionView.reloadData()
//                    
////                    self.todoCollectionView.performBatchUpdates({
////                        self.todoCollectionView.delete
////                    })
//                } catch let error as NSError {
//                    print("Silme işlemi sırasında hata oluştu: \(error), \(error.userInfo)")
//                }
//            }
//        }

        cell.aboutLabel.text = data.value(forKey: "about") as? String
    }
    
//    func deleteItemAt(indexPath: IndexPath) {
//        guard let context = context else {return}
//        context.delete(savedData[indexPath.row])
//        do{
//            try context.save()
//            savedData.remove(at: indexPath.row)
//            reloadCollectionView?()
//        }catch {
//            print("Error")
//        }
//    }
    
//    func selectItem(at indexPath: IndexPath) -> NSManagedObject {
//        return savedData[indexPath.row]
//    }
}
extension CalendarViewModel {
    fileprivate func formattedDateAndTime(from timeInterval: TimeInterval, style: DateFormatter.Style) -> String? {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(style == .short  ? "HH:mm" : "MMM d, yyyy")
        return formatter.string(from: date)
    }
}
