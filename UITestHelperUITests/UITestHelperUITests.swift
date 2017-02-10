//
//  UITestHelperUITests.swift
//  UITestHelperUITests
//
//  Created by Edwin Vermeer on 03/02/2017.
//  Copyright © 2017 evict. All rights reserved.
//

import XCTest
import UITestHelper

class UITestHelperUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        self.tryLaunch([LaunchArguments.MockNetworkResponses])
    }
    
    func testAppWaitForElement() {
        XCTAssert(app.staticTexts["This is a label"].waitUntilExists().exists, "label should exist")
        app.staticTexts["This is a label"].waitUntilExistsAssert()
        app.buttons["Second"].waitUntilExists().tap()
        app.buttons["Button"].waitUntilExists().tap()
    }

    func testAppTextEntry() {
        app.textFields["This is a text field"].tapAndType("testing")
    }
    
    func testAppOneOfTheseShouldExist() {
        app.staticTexts["This is a label"].or(app.textFields["This is a text field"]).tap()
        app.staticTexts["This is a label"].orAssert(app.textFields["This is a text field"])
    }
    
    func testAppConditionalCode() {
        // Only execute the closure if the element is there.
        app.buttons["Button"].ifExists { $0.tap() } // The button exist, so we do tap it
        app.buttons["Hide"].ifExists { $0.tap() } // The button does not exist, so we don't tap it
        
        // Only execute the closure if the element is not there
        app.alerts.buttons["Hide"].ifNotExist(2) {
            app.buttons["Third"].waitUntilExists().tap()
        }

        // Only execute the closure if the element is not there and then continue assuming it's there.
        app.buttons["Hide"].ifNotExistwaitUntilExists(2) {
            app.buttons["Show"].waitUntilExists().tap()
        }.tap()
        sleep(3)
    }
    
    func testAppSwitches() {
        app.switches.element(boundBy: 0).setSwitch(false)
        app.switches.element(boundBy: 1).setSwitch(false)
        app.switches.element(boundBy: 0).setSwitch(true)
        app.switches.element(boundBy: 0).setSwitch(false)
        app.switches.element(boundBy: 1).setSwitch(true)
    }
}
