//
//  ReminderServiceTests.swift
//  Reminder
//
//  Created by Lucas Castro on 31/10/24.
//

import XCTest
import CoreData
@testable import Reminder

class ReminderServiceTests: XCTestCase {
    
    var reminderService: ReminderService!
    var inMemoryContext: NSManagedObjectContext!
    

    override func setUpWithError() throws {
        inMemoryContext = PersistenceController(inMemory: true).container.viewContext
        reminderService = ReminderService(context: inMemoryContext)
    }

    override func tearDownWithError() throws {
        reminderService = nil
        inMemoryContext = nil
    }

    func testAddReminder() {
        let initialCount = reminderService.fetchReminders().count
        reminderService.addReminder(title: "Estudar Swift", date: Date())
        let finalCount = reminderService.fetchReminders().count
        
        XCTAssertEqual(finalCount, initialCount + 1, "A contagem de lembretes deveria ter aumentado em 1.")
        XCTAssertTrue(reminderService.fetchReminders().contains { $0.title == "Estudar Swift" }, "O lembrete não foi encontrado na lista.")
    }
    
    func testFetchReminders() {
        reminderService.addReminder(title: "Ler livro", date: Date())
        reminderService.addReminder(title: "Fazer exercícios", date: Date())
        
        let reminders = reminderService.fetchReminders()
        XCTAssertEqual(reminders.count, 2, "Deveria haver 2 lembretes adicionados.")
        XCTAssertTrue(reminders.contains { $0.title == "Ler livro" }, "Lembrete 'Ler livro' deveria estar na lista.")
        XCTAssertTrue(reminders.contains { $0.title == "Fazer exercícios" }, "Lembrete 'Fazer exercícios' deveria estar na lista.")
    }

    func testDeleteReminder() {
        reminderService.addReminder(title: "Limpar casa", date: Date())
        let reminders = reminderService.fetchReminders()
        guard let reminderToDelete = reminders.first else {
            XCTFail("Nenhum lembrete encontrado para deletar.")
            return
        }
        
        reminderService.deleteReminder(reminderToDelete)
        
        let updatedReminders = reminderService.fetchReminders()
        XCTAssertFalse(updatedReminders.contains(reminderToDelete), "O lembrete deveria ter sido removido.")
    }
    
    func testUpdateReminder() {
        reminderService.addReminder(title: "Comprar frutas", date: Date())
        let reminders = reminderService.fetchReminders()
        guard let reminderToUpdate = reminders.first else {
            XCTFail("Nenhum lembrete encontrado para atualizar.")
            return
        }
        
        let newTitle = "Comprar verduras"
        let newDate = Date()
        reminderService.updateReminder(reminderToUpdate, title: newTitle, date: newDate)
        
        let updatedReminders = reminderService.fetchReminders()
        guard let updatedReminder = updatedReminders.first else {
            XCTFail("Nenhum lembrete encontrado após atualização.")
            return
        }
        
        XCTAssertEqual(updatedReminder.title, newTitle, "O título do lembrete deveria ter sido atualizado.")
        XCTAssertEqual(updatedReminder.date, newDate, "A data do lembrete deveria ter sido atualizada.")
    }

    func testToggleCompletion() {
        reminderService.addReminder(title: "Comprar frutas", date: Date())
        let reminders = reminderService.fetchReminders()
        guard let reminder = reminders.first else {
            XCTFail("Nenhum lembrete encontrado para alternar status de conclusão.")
            return
        }
        
        let initialStatus = reminder.isCompleted
        reminderService.toggleCompletion(for: reminder)
        
        XCTAssertNotEqual(reminder.isCompleted, initialStatus, "O status de conclusão do lembrete deveria ter sido alterado.")
    }
}
