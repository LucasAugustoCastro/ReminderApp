//
//  ReminderApp.swift
//  Reminder
//
//  Created by Lucas Castro on 03/11/24.
//


import XCTest
import CoreData
@testable import Reminder

final class ReminderAppTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    func testReminderCreateViewUIElements() throws {
        let app = XCUIApplication()
        app.navigationBars.buttons["addReminderButton"].tap()
        
        XCTAssertTrue(app.textFields["Title"].exists, "O campo de título não está presente")
        XCTAssertTrue(app.datePickers["Date"].exists, "O seletor de data não está presente")
        XCTAssertTrue(app.buttons["Save"].exists, "O botão de salvar não está presente")
    }
    
    func testAddNewReminder() throws {
        let app = XCUIApplication()
        
        createReminder(on: app)
        let reminderList = app.collectionViews["ReminderList"]
        if reminderList.waitForExistence(timeout: 3.0) {
            XCTAssertTrue(reminderList.exists, "A lista de lembretes não está presente")
            XCTAssertTrue(reminderList.cells.staticTexts["Meu novo lembrete"].exists, "O lembrete não foi adicionado à lista")
        } else {
            XCTFail("A lista de lembretes não foi carregada")
        }
        
    }
    func testEditReminder() throws {
        let app = XCUIApplication()
        createReminder(on: app)
        
        let reminderList = app.collectionViews["ReminderList"]
        let cell = reminderList.cells.element(boundBy: 0)
        cell.tap()
        
        let titleField = app.textFields["Title"]
        XCTAssertTrue(titleField.exists, "O campo de título não está presente")
        titleField.tap()
        titleField.typeText("Meu lembrete editado")
        
        let datePicker = app.datePickers["Date"]
        XCTAssertTrue(datePicker.exists, "O seletor de data não está presente")

        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists, "O botão de salvar não está presente")
        saveButton.tap()
        XCTAssertFalse(titleField.exists, "A tela de edição não foi fechada após editar o lembrete")
    }
    
    func testDeleteReminder() throws {
        let app = XCUIApplication()
        createReminder(on: app)
        
        let reminderList = app.collectionViews["ReminderList"]
        let cell = reminderList.cells.element(boundBy: 0)
        cell.tap()
        app.buttons["Delete"].tap()
        
        XCTAssertFalse(cell.exists, "O lembrete não foi removido da lista")
    }
    
    private func createReminder(on app: XCUIApplication) {
        app.navigationBars.buttons["addReminderButton"].tap()
        
        let titleField = app.textFields["Title"]
        XCTAssertTrue(titleField.exists, "O campo de título não está presente")
        titleField.tap()
        titleField.typeText("Meu novo lembrete")
        
        let datePicker = app.datePickers["Date"]
        XCTAssertTrue(datePicker.exists, "O seletor de data não está presente")
        
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists, "O botão de salvar não está presente")
        saveButton.tap()
        XCTAssertFalse(titleField.exists, "A tela de criação não foi fechada após salvar o lembrete")
    }
}
