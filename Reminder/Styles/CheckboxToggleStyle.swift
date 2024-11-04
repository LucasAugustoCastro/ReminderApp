//
//  CheckboxToggleStyle.swift
//  Reminder
//
//  Created by Lucas Castro on 02/11/24.
//
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            // Ícone de checkbox que muda conforme o estado do Toggle (isOn)
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture {
                    // Alterna o estado do Toggle
                    configuration.isOn.toggle()
                }
            
            // Label do Toggle, que pode ser um título ou outra descrição
            configuration.label
        }
    }
}
