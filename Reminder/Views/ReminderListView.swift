//
//  ReminderListView.swift
//  Reminder
//
//  Created by Lucas Castro on 02/11/24.
//

import SwiftUI

struct ReminderListView: View {
    @ObservedObject var viewModel: ReminderViewModel
    @State private var selectedReminder: Reminder?
    var body: some View {
        NavigationView {
            
            List(viewModel.reminders) { reminder in
                HStack{
                    Toggle(isOn: Binding(
                        get: { reminder.isCompleted },
                        set: { newValue in
                            viewModel.toggleCompletion(for: reminder)
                        }
                    )) {
                        VStack{
                            Text(reminder.title ?? "Sem Título")
                                .strikethrough(reminder.isCompleted, color: .gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(reminder.date?.formatted() ?? "")
                                .strikethrough(reminder.isCompleted, color: .gray)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.leading, 10)
                        .accessibilityIdentifier("ReminderCell")
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    
                    Spacer()
                    
                    NavigationLink(destination: ReminderEditView(viewModel: viewModel, reminder: .constant(reminder))) {
                        EmptyView()
                    }
                    .frame(width: 0)
                    .opacity(0)
                }
                
            }
            .accessibilityIdentifier("ReminderList")
            .navigationTitle("Lembretes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ReminderCreateView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("addReminderButton")
                }
            }
            
        }
    }
}

#Preview {
    let viewModel = ReminderViewModel(reminderService: MockReminderService())
    ReminderListView(viewModel: viewModel)
}
class MockReminderService: ReminderServiceProtocol {
    func fetchReminders() -> [Reminder] {
        let reminder1 = Reminder()
        reminder1.title = "Comprar frutas"
        reminder1.isCompleted = false

        let reminder2 = Reminder()
        reminder2.title = "Estudar SwiftUI"
        reminder2.isCompleted = true

        return [reminder1, reminder2]
    }

    func addReminder(title: String, date: Date) { }
    func deleteReminder(_ reminder: Reminder) { }
    func toggleCompletion(for reminder: Reminder) { }
    func updateReminder(_ reminder: Reminder, title: String, date: Date?) { }
}

