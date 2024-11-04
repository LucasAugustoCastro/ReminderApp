//
//  ReminderViewModelTests.swift
//  ReminderTests
//
//  Created by Lucas Castro on 31/10/24.
//

import XCTest
import CoreData
@testable import Reminder // Importa o módulo principal do app para acessar ReminderService e Reminder

class ReminderViewModelTests: XCTestCase {

    var reminderService: ReminderService!
    var inMemoryContext: NSManagedObjectContext!
    var reminderViewModel: ReminderViewModel!

    override func setUpWithError() throws {
        // Configuração do Core Data em memória
        inMemoryContext = PersistenceController(inMemory: true).container.viewContext
        reminderService = ReminderService(context: inMemoryContext)
        reminderViewModel = ReminderViewModel(reminderService: reminderService)
    }

    override func tearDownWithError() throws {
        // Desfaz as configurações para garantir um ambiente limpo para outros testes
        reminderService = nil
        inMemoryContext = nil
        reminderViewModel = nil
    }
    
    func testAddReminder() {
        let initialCount = reminderViewModel.reminders.count
        reminderViewModel.addReminder(title: "Estudar Swift", date: Date())
        let finalCount = reminderViewModel.reminders.count
        XCTAssertEqual(finalCount, initialCount + 1, "A contagem de lembretes deveria ter aumentado em 1.")
        XCTAssertTrue(reminderViewModel.reminders.contains { $0.title == "Estudar Swift" }, "O lembrete não foi encontrado na lista.")
    }
    
    func testUpdateReminder() {
        reminderViewModel.addReminder(title: "Estudar Swift", date: Date())
        let reminder = reminderViewModel.reminders.first( where: {$0.title == "Estudar Swift"} )
        reminderViewModel.editReminder(reminder: reminder!, title: "Estudar SwiftUI", date: Date())
        XCTAssertTrue(reminderViewModel.reminders.contains { $0.title == "Estudar SwiftUI" }, "O lembrete não foi encontrado na lista.")
    }
    
    func testDeleteReminder() {
        reminderViewModel.addReminder(title: "Estudar Swift", date: Date())
        reminderViewModel.addReminder(title: "Estudar SwiftUI", date: Date())
    
        let reminder = reminderViewModel.reminders.first( where: {$0.title == "Estudar Swift"} )
        reminderViewModel.deleteReminder(reminder!)
        XCTAssertEqual(reminderViewModel.reminders.count, 1, "A contagem de lembretes deve ser 1")
        XCTAssertTrue(reminderViewModel.reminders.contains { $0.title == "Estudar SwiftUI" }, "O lembrete não foi encontrado na lista.")
    }

}
