//
//  ReminderEditView.swift
//  Reminder
//
//  Created by Lucas Castro on 02/11/24.
//

import SwiftUI

struct ReminderEditView: View {
    @ObservedObject var viewModel: ReminderViewModel
    @Binding var reminder: Reminder
    @State private var title: String = ""
    @State private var date: Date = Date()

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TextField("Editar Título", text: $title)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .accessibilityIdentifier("Title")
            DatePicker("Data do Lembrete", selection: $date)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .accessibilityIdentifier("Date")
            Spacer()
            Button(action: {
                viewModel.editReminder(reminder: reminder, title: title, date: date)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Salvar Alterações")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .accessibilityIdentifier("Save")
            Button(action: {
                viewModel.deleteReminder(reminder)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Deletar Lembrete")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            .accessibilityIdentifier("Delete")
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .navigationTitle("Editar Lembrete")
        .onAppear {
            title = reminder.title ?? ""
            date = reminder.date ?? Date()
        }
    }
}

#Preview {
    let viewModel = ReminderViewModel(reminderService: MockReminderService())
    let reminder = viewModel.reminders[0]
    ReminderEditView(viewModel: viewModel, reminder: .constant(reminder))
}
