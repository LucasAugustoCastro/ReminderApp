//
//  ReminderService.swift
//  Reminder
//
//  Created by Lucas Castro on 31/10/24.
//

import CoreData

protocol ReminderServiceProtocol {
    func addReminder(title: String, date: Date)
    func fetchReminders() -> [Reminder]
    func deleteReminder(_ reminder: Reminder)
    func updateReminder(_ reminder: Reminder, title: String, date: Date?)
    func toggleCompletion(for reminder: Reminder)
}

class ReminderService: ReminderServiceProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addReminder(title: String, date: Date) {
        let reminder = Reminder(context: context)
        reminder.id = UUID()
        reminder.title = title
        reminder.date = date
        reminder.isCompleted = false
        saveContext()
    }
    
    func fetchReminders() -> [Reminder] {
        let fetchRequest: NSFetchRequest<Reminder> = Reminder.fetchRequest()
        let sortByCompletion = NSSortDescriptor(keyPath: \Reminder.isCompleted, ascending: true)
        let sortByDate = NSSortDescriptor(keyPath: \Reminder.date, ascending: true)
        fetchRequest.sortDescriptors = [sortByCompletion, sortByDate]
        do {
            return try self.context.fetch(fetchRequest)
        } catch {
            print("Failed to laod Reminders")
            return []
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        context.delete(reminder)
        saveContext()
    }
    
    func toggleCompletion(for reminder: Reminder) {
        reminder.isCompleted.toggle()
        saveContext()
    }
    func updateReminder(_ reminder: Reminder, title: String, date: Date?) {
        reminder.title = title
        reminder.date = date
        saveContext()
    }
    
    private func saveContext() {
        do {
            try self.context.save()
        } catch {
            print("Failed to save Reminder")
        }
    }
}
