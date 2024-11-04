//
//  ReminderCreateViewTests.swift
//  ReminderUITests
//
//  Created by Lucas Castro on 03/11/24.
//

import XCTest

final class ReminderCreateViewTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
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

        let reminderList = app.collectionViews["ReminderList"]
        if reminderList.waitForExistence(timeout: 3.0) {
            XCTAssertTrue(reminderList.exists, "A lista de lembretes não está presente")
            XCTAssertTrue(reminderList.cells.staticTexts["Meu novo lembrete"].exists, "O lembrete não foi adicionado à lista")
        } else {
            XCTFail("A lista de lembretes não foi carregada")
        }
        
    }
}
