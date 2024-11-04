//
//  ReminderViewModel.swift
//  Reminder
//
//  Created by Lucas Castro on 31/10/24.
//
import Foundation
import SwiftUI
import Combine

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    private let reminderService: ReminderServiceProtocol
    
    init(reminderService: ReminderServiceProtocol) {
        self.reminderService = reminderService
        self.reminders = reminderService.fetchReminders()
    }
    
    func addReminder(title: String, date: Date) {
        reminderService.addReminder(title: title, date: date)
        refreshReminders()
    }
    
    func deleteReminder(_ reminder: Reminder) {
        reminderService.deleteReminder(reminder)
        refreshReminders()
    }
    
    func toggleCompletion(for reminder: Reminder) {
        reminderService.toggleCompletion(for: reminder)
        refreshReminders()
    }
    func editReminder(reminder: Reminder, title: String, date: Date) {
        reminderService.updateReminder(reminder, title: title, date: date)
        refreshReminders()
    }
    
    private func refreshReminders() {
        self.reminders = reminderService.fetchReminders()
    }
}
