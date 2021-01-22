//
//  LoginUITest.swift
//  finchiosUITests
//
//  Created by Brett Fazio on 1/22/21.
//

import XCTest

class LoginUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBackAndForth() throws {
        let app = XCUIApplication()
        //TODO(): make extension for app to do all this
        app.launchEnvironment = ["key": "val"]
        app.launchArguments = ["UI-Testing"]
        app.launch()
        
        app.buttons["Already have an account? Log in."].tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        app.buttons["Already have an account? Log in."].tap()
        
        assert(app.buttons["Already have an account? Log in."].isHittable == false)
        
        assert(app.navigationBars.buttons.count > 0)
    }
    
    func testLogIn() throws {
        let app = XCUIApplication()
        //TODO(): make extension for app to do all this
        app.launchEnvironment = ["key": "val"]
        app.launchArguments = ["UI-Testing"]
        app.launch()
        
        app.buttons["Already have an account? Log in."].tap()
        
        app.textFields["Email"].tap()
        
        app.typeText("t@t.t")
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        
        // Make sure hardware keyboard usage is off in simulator.
        passwordField.typeText("123")
        app.buttons["Return"].tap()
        
        app.buttons["Log in!"].tap()
        
        sleep(2)
        
        app.buttons["Okay"].tap()
        
        // Log In button should not be there anymore
        let login = app.buttons["Log in!"]
        let exists = NSPredicate(value: login.isHittable == false)
        
        expectation(for: exists, evaluatedWith: login, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        assert(app.navigationBars.buttons.count == 0)

    }

}
