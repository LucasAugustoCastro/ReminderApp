//
//  ReminderApp.swift
//  Reminder
//
//  Created by Lucas Castro on 31/10/24.
//

import SwiftUI

@main
struct ReminderApp: App {
    let persistenceController = PersistenceController.shared
    static var isRunningTests: Bool {
        return ProcessInfo().arguments.contains("enable-testing")
    }
    var body: some Scene {
        WindowGroup {
            if (ReminderApp.isRunningTests) {
                let teste = PersistenceController(inMemory: true)
                // Cria o ReminderViewModel usando o serviço real ou um mock para inicialização
                let reminderService = ReminderService(context: teste.container.viewContext)
                let reminderViewModel = ReminderViewModel(reminderService: reminderService)
                // Passa o ViewModel para a ReminderListView
                ReminderListView(viewModel: reminderViewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                // Cria o ReminderViewModel usando o serviço real ou um mock para inicialização
                let reminderService = ReminderService(context: persistenceController.container.viewContext)
                let reminderViewModel = ReminderViewModel(reminderService: reminderService)
                // Passa o ViewModel para a ReminderListView
                ReminderListView(viewModel: reminderViewModel)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
            
        }
    }
}
