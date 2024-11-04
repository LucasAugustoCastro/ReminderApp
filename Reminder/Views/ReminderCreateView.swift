//
//  ReminderCreateView.swift
//  Reminder
//
//  Created by Lucas Castro on 02/11/24.
//

import SwiftUI

struct ReminderCreateView: View {
    @ObservedObject var viewModel: ReminderViewModel
    @State private var title = ""
    @State private var date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            TextField("Título do Lembrete", text: $title)
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
                viewModel.addReminder(title: title, date: date)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Salvar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .accessibilityIdentifier("Save")
        }
        .navigationTitle("Novo Lembrete")
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

#Preview {
    let viewModel = ReminderViewModel(reminderService: MockReminderService())
    ReminderListView(viewModel: viewModel)
}

