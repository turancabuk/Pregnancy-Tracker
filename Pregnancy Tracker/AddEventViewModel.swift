//
//  AddEventViewModel.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 25.04.2024.
//

import UIKit
import CoreData
import EventKit

protocol AddEventViewModelDelegate: AnyObject {
    func didAddEvent()
    func didFailWithError(message: String)
}

class AddEventViewModel {
    
    private let eventStore: EKEventStore
    private let entityName = "Doctor"
    private var managedObjectContext: NSManagedObjectContext?
    var selectedDate: Date?
    var delegate: AddEventViewModelDelegate?

    init(eventStore: EKEventStore) {
        self.eventStore = eventStore
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedObjectContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func addEvent(aboutText: String, noteText: String, selectedTime: Date) {
        guard let selectedDate = selectedDate else {
            delegate?.didFailWithError(message: "Selected date is not set.")
            return
        }

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        let combinedComponents = DateComponents(year: dateComponents.year, month: dateComponents.month, day: dateComponents.day, hour: timeComponents.hour, minute: timeComponents.minute)

        if let eventDate = calendar.date(from: combinedComponents) {
            requestCalendarAccess { [weak self] granted in
                if granted {
                    self?.createEvent(title: aboutText, description: noteText, startDate: eventDate)
                    self?.saveToCoreData(aboutText: aboutText, noteText: noteText, date: selectedDate, time: selectedTime)
                } else {
                    self?.delegate?.didFailWithError(message: "Calendar access denied.")
                }
            }
        } else {
            delegate?.didFailWithError(message: "Failed to combine date and time components.")
        }
    }

    private func requestCalendarAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestFullAccessToEvents { granted, error in
            DispatchQueue.main.async {
                if granted && error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

    private func createEvent(title: String, description: String, startDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate)
        event.notes = description
        event.calendar = eventStore.defaultCalendarForNewEvents

        let alarm = EKAlarm(relativeOffset: -15 * 60)
        event.addAlarm(alarm)
        
        do {
            try eventStore.save(event, span: .thisEvent)
            delegate?.didAddEvent()
        } catch {
            delegate?.didFailWithError(message: "Failed to save event to the calendar.")
        }
    }

    private func saveToCoreData(aboutText: String, noteText: String, date: Date, time: Date) {
        guard let context = managedObjectContext, let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            delegate?.didFailWithError(message: "Core Data setup error.")
            return
        }

        let newItem = NSManagedObject(entity: entity, insertInto: context)
        newItem.setValue(aboutText, forKey: "about")
        newItem.setValue(noteText, forKey: "note")
        newItem.setValue(NSNumber(value: date.timeIntervalSince1970), forKey: "date")
        newItem.setValue(NSNumber(value: time.timeIntervalSince1970), forKey: "time")
        do {
            try context.save()
            NotificationCenter.default.post(name: .eventAdded, object: newItem)
        } catch {
            delegate?.didFailWithError(message: "Failed to save event to CoreData.")
        }
    }
}
